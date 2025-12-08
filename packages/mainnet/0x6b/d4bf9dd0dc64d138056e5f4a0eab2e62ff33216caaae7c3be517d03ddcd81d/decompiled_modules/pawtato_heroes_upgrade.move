module 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes_upgrade {
    struct HeroUpgradeStats has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct HeroUpgradeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HeroStatUpgraded has copy, drop {
        user: address,
        hero_id: 0x2::object::ID,
        stat_name: 0x1::string::String,
        old_value: u16,
        new_value: u16,
    }

    struct HeroStatRerolled has copy, drop {
        user: address,
        hero_id: 0x2::object::ID,
        stat_name: 0x1::string::String,
        old_value: u16,
        new_value: u16,
    }

    fun get_stat_name(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Vitality")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Agility")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Strength")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Dexterity")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Intelligence")
        } else {
            assert!(arg0 == 5, 6);
            0x1::string::utf8(b"Luck")
        }
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HeroUpgradeAdminCap{id: 0x2::object::new(arg1)};
        let v1 = HeroUpgradeStats{
            id      : 0x2::object::new(arg1),
            version : 1,
            paused  : false,
        };
        0x2::transfer::transfer<HeroUpgradeAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<HeroUpgradeStats>(v1);
    }

    public entry fun reroll_hero_stat<T0>(arg0: &mut 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::HeroStakingPool, arg1: &mut HeroUpgradeStats, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(!arg1.paused, 2);
        assert!(arg4 <= 5, 6);
        validate_urr_coin_type<T0>(arg0, 0);
        assert!(0x2::coin::value<T0>(&arg5) >= 1000000000, 4);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg2, arg5);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::random::new_generator(arg6, arg7);
        let v2 = 0x2::random::generate_u16_in_range(&mut v1, 6, 12);
        0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::set_hero_cached_trait(arg0, v0, arg3, arg4, v2);
        0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::update_hero_attribute(0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::borrow_hero_mut(arg0, arg3), get_stat_name(arg4), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string((v2 as u64)));
        let v3 = HeroStatRerolled{
            user      : v0,
            hero_id   : arg3,
            stat_name : get_stat_name(arg4),
            old_value : 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::get_hero_cached_trait(arg0, v0, arg3, arg4),
            new_value : v2,
        };
        0x2::event::emit<HeroStatRerolled>(v3);
    }

    public entry fun set_paused(arg0: &HeroUpgradeAdminCap, arg1: &mut HeroUpgradeStats, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun upgrade_hero_stat<T0>(arg0: &mut 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::HeroStakingPool, arg1: &mut HeroUpgradeStats, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(!arg1.paused, 2);
        assert!(arg4 <= 5, 6);
        validate_urr_coin_type<T0>(arg0, 1);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= 1000000000, 4);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::get_hero_cached_trait(arg0, v1, arg3, arg4);
        assert!(v2 < 12, 3);
        let v3 = v0 / 1000000000;
        let v4 = ((12 - v2) as u64);
        let v5 = if (v3 < v4) {
            v3
        } else {
            v4
        };
        let v6 = v2 + (v5 as u16);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg2, arg5);
        0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::set_hero_cached_trait(arg0, v1, arg3, arg4, v6);
        0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::update_hero_attribute(0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::borrow_hero_mut(arg0, arg3), get_stat_name(arg4), 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string((v6 as u64)));
        let v7 = HeroStatUpgraded{
            user      : v1,
            hero_id   : arg3,
            stat_name : get_stat_name(arg4),
            old_value : v2,
            new_value : v6,
        };
        0x2::event::emit<HeroStatUpgraded>(v7);
    }

    public entry fun upgrade_version(arg0: &HeroUpgradeAdminCap, arg1: &mut HeroUpgradeStats, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    fun validate_urr_coin_type<T0>(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::HeroStakingPool, arg1: u64) {
        let v0 = 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::get_urr_coin_types(arg0);
        assert!(0x1::vector::length<0x1::string::String>(&v0) > arg1, 5);
        assert!(*0x1::vector::borrow<0x1::string::String>(&v0, arg1) == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(), 5);
    }

    // decompiled from Move bytecode v6
}

