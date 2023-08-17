use array::ArrayTrait;
use starknet::ContractAddress;
use option::{Option, OptionTrait};
use debug::PrintTrait;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Card {
    /// The token id in the NFT contract of this card.
    #[key]
    token_id: u256,
    /// Dribble statistic of the card.
    dribble: u8,
    /// Current dribble stat, depending on card placement
    current_dribble: u8,
    /// Defense statistic of the card.
    defense: u8,
    /// Current defense stat, depending on card placement
    current_defense: u8,
    /// Energy cost of the card.
    cost: u8,
    /// Assigned role
    role: Roles,
    /// Card is currently captain of the team
    is_captain: bool,
}

#[derive(Copy, Drop, Serde)]
enum Roles {
    A,
    B,
    C,
    D,
}

impl RolesSerdeLen of dojo::SerdeLen<Roles> {
    #[inline(always)]
    fn len() -> usize {
        4
    }
}

#[cfg(test)]
impl RolesPrint of debug::PrintTrait<Roles> {
    fn print(self: Roles) {
        match self {
            Roles::A => 'Goalkeeper'.print(),
            Roles::B => 'Defender'.print(),
            Roles::C => 'Midfielder'.print(),
            Roles::D => 'Attacker'.print(),
        }
    }
}
