module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero_helper {
    struct HelpMeSlayThisMonster has key {
        id: 0x2::object::UID,
        monster: 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::SeaMonster,
        monster_owner: address,
        helper_reward: u64,
    }

    public fun slay(arg0: &0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::hero::Hero, arg1: HelpMeSlayThisMonster, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::RUM> {
        let HelpMeSlayThisMonster {
            id            : v0,
            monster       : v1,
            monster_owner : v2,
            helper_reward : v3,
        } = arg1;
        0x2::object::delete(v0);
        let v4 = 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::slay(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::RUM>>(0x2::coin::from_balance<0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::RUM>(v4, arg2), v2);
        0x2::coin::take<0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::RUM>(&mut v4, v3, arg2)
    }

    public fun create(arg0: 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::SeaMonster, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::monster_reward(&arg0) > arg1, 0);
        let v0 = HelpMeSlayThisMonster{
            id            : 0x2::object::new(arg3),
            monster       : arg0,
            monster_owner : 0x2::tx_context::sender(arg3),
            helper_reward : arg1,
        };
        0x2::transfer::transfer<HelpMeSlayThisMonster>(v0, arg2);
    }

    public fun owner_reward(arg0: &HelpMeSlayThisMonster) : u64 {
        0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::monster_reward(&arg0.monster) - arg0.helper_reward
    }

    public fun return_to_owner(arg0: HelpMeSlayThisMonster) {
        let HelpMeSlayThisMonster {
            id            : v0,
            monster       : v1,
            monster_owner : v2,
            helper_reward : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::sea_hero::SeaMonster>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

