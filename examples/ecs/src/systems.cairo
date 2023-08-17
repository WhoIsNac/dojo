#[system]
mod create_card_system {
    use traits::Into;

    use dojo::world::Context;
    use starknet::ContractAddress;
    use dojo_examples::components::Card;
    use dojo_examples::components::Roles;
    use option::{Option, OptionTrait};
    use traits::TryInto;


    //This part is for test prupose
    fn execute(ctx: Context, token_id: felt252, role: felt252, dribble: felt252) {
        set!(
            ctx.world, Card {
                token_id: token_id.into(),
                dribble: dribble.try_into().unwrap(),
                current_dribble: 10,
                defense: 10,
                current_defense: 10,
                cost: 10,
                role: Roles::A,
                is_captain: false
            }
        );

        let token_id = get!(ctx.world, token_id, Card);
    }
}


#[cfg(test)]
mod tests {
    use array::ArrayTrait;
    use option::{Option, OptionTrait};
    use debug::PrintTrait;
    use dojo::world::IWorldDispatcherTrait;

    use dojo_examples::components::{Card, card};
    use dojo_examples::systems::create_card_system;
    use traits::Into;
    use traits::TryInto;

    use dojo::test_utils::spawn_test_world;


    #[test]
    #[available_gas(30000000)]
    fn test_card() {
        // let mut systems = array![create_card_system::TEST_CLASS_HASH];
        // let mut components = array![card::TEST_CLASS_HASH];
        let mut components = array::ArrayTrait::new();
        components.append(card::TEST_CLASS_HASH);

        let mut systems = array::ArrayTrait::new();
        systems.append(create_card_system::TEST_CLASS_HASH);

        // deploy executor, world and register components/systems
        let world = spawn_test_world(components, systems);

        //Create Card For test prupose
        let mut create_card_calldata: Array<felt252> = ArrayTrait::new();
        create_card_calldata.append(1);
        create_card_calldata.append(0);
        create_card_calldata.append(12);
        world.execute('create_card_system', create_card_calldata);

        let mut create_card_calldata_player2: Array<felt252> = ArrayTrait::new();
        create_card_calldata_player2.append(2);
        create_card_calldata_player2.append(0);
        create_card_calldata_player2.append(10);
        world.execute('create_card_system', create_card_calldata_player2);

        let mut token_id_player1: u256 = 1;
        let card_player1 = get!(world, token_id_player1, Card);
        // let card_player2 = get!(world, 0, Card);

        assert(card_player1.dribble == 12, 'defense is wrong');
    }
}
