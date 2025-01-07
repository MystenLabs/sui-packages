module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero {
    struct SeaHeroAdmin has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<RUM>,
        monsters_created: u64,
        token_supply_max: u64,
        monster_max: u64,
    }

    struct SeaMonster has store, key {
        id: 0x2::object::UID,
        reward: 0x2::balance::Balance<RUM>,
    }

    struct RUM has drop {
        dummy_field: bool,
    }

    public entry fun create_monster(arg0: &mut SeaHeroAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.token_supply_max;
        assert!(arg1 < v0, 0);
        assert!(v0 - arg1 >= 0x2::balance::supply_value<RUM>(&arg0.supply), 1);
        assert!(arg0.monster_max - 1 >= arg0.monsters_created, 2);
        let v1 = SeaMonster{
            id     : 0x2::object::new(arg3),
            reward : 0x2::balance::increase_supply<RUM>(&mut arg0.supply, arg1),
        };
        arg0.monsters_created = arg0.monsters_created + 1;
        0x2::transfer::public_transfer<SeaMonster>(v1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RUM{dummy_field: false};
        let v1 = SeaHeroAdmin{
            id               : 0x2::object::new(arg0),
            supply           : 0x2::balance::create_supply<RUM>(v0),
            monsters_created : 0,
            token_supply_max : 1000000,
            monster_max      : 10,
        };
        0x2::transfer::transfer<SeaHeroAdmin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun monster_reward(arg0: &SeaMonster) : u64 {
        0x2::balance::value<RUM>(&arg0.reward)
    }

    public fun slay(arg0: &0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::hero::Hero, arg1: SeaMonster) : 0x2::balance::Balance<RUM> {
        let SeaMonster {
            id     : v0,
            reward : v1,
        } = arg1;
        let v2 = v1;
        0x2::object::delete(v0);
        assert!(0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::hero::hero_strength(arg0) >= 0x2::balance::value<RUM>(&v2), 0);
        v2
    }

    // decompiled from Move bytecode v6
}

