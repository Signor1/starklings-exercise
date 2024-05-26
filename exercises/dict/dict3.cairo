use core::dict::{Felt252Dict, Felt252DictTrait};

#[derive(Destruct)]
struct Team {
    level: Felt252Dict<usize>,
    players_count: usize
}

#[generate_trait]
impl TeamImpl of TeamTrait {
    fn new() -> Team {
        //TODO : initialize empty team with 0 player
        Team{
            level: Default::default(),
            players_count: 0_usize
        }
    }

    fn get_level(ref self: Team, name: felt252) -> usize {
        //TODO 
        self.level.get(name)
    }

    fn add_player(ref self: Team, name: felt252, level: usize) {
        //TODO
       self.level.insert(name, level);
       self.players_count += 1_usize; 
    }

    fn level_up(ref self: Team, name: felt252) {
        //TODO
        let mut level: usize = self.level.get(name);
        self.level.insert(name, level + 1_usize)
    
    }

    fn players_count(self: @Team) -> usize {
        //TODO
        *self.players_count
    }
}


#[test]
#[available_gas(200000)]
fn test_add_player() {
    let mut team = TeamTrait::new();
    team.add_player('bob', 10);
    team.add_player('alice', 20);

    assert(team.players_count == 2, 'Wrong number of player');
    assert(team.get_level('bob') == 10, 'Wrong level');
    assert(team.get_level('alice') == 20, 'Wrong level');
}

#[test]
#[available_gas(200000)]
fn test_level_up() {
    let mut team = TeamTrait::new();
    team.add_player('bobby', 10);
    team.level_up('bobby');

    assert(team.level.get('bobby') == 11, 'Wrong level');
}
