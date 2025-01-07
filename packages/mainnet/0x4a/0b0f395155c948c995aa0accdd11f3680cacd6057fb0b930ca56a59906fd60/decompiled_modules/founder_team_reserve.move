module 0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::founder_team_reserve {
    struct FounderTeamGlobal has key {
        id: 0x2::object::UID,
        phase_start_time: u64,
        current_phase: u64,
        creator: address,
        balance_SHUI: 0x2::balance::Balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>,
        whitelist_500: 0x2::table::Table<address, u64>,
        whitelist_300: 0x2::table::Table<address, u64>,
        whitelist_200: 0x2::table::Table<address, u64>,
        whitelist_100: 0x2::table::Table<address, u64>,
        whitelist_50: 0x2::table::Table<address, u64>,
        whitelist_20: 0x2::table::Table<address, u64>,
        whitelist_10: 0x2::table::Table<address, u64>,
        address_set: 0x2::table::Table<address, u64>,
        version: u64,
    }

    public entry fun add_white_list(arg0: &mut FounderTeamGlobal, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 6);
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        assert!(!0x2::table::contains<address, u64>(&arg0.address_set, arg1), 3);
        0x2::table::add<address, u64>(&mut arg0.address_set, arg1, 1);
        if (arg2 == 500) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_500, arg1, 20);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_500) <= 1, 2);
        } else if (arg2 == 300) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_300, arg1, 20);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_300) <= 1, 2);
        } else if (arg2 == 200) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_200, arg1, 20);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_200) <= 4, 2);
        } else if (arg2 == 100) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_100, arg1, 10);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_100) <= 2, 2);
        } else if (arg2 == 50) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_50, arg1, 10);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_50) <= 4, 2);
        } else if (arg2 == 20) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_20, arg1, 10);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_20) <= 1, 2);
        } else if (arg2 == 10) {
            0x2::table::add<address, u64>(&mut arg0.whitelist_10, arg1, 1);
            assert!(0x2::table::length<address, u64>(&arg0.whitelist_10) <= 8, 2);
        };
    }

    public fun change_owner(arg0: &mut FounderTeamGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.creator = arg1;
    }

    public entry fun claim_reserve(arg0: &mut FounderTeamGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 6);
        assert!(arg0.current_phase > 0, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg1 == 500) {
            0x1::debug::print<u64>(0x2::table::borrow<address, u64>(&arg0.whitelist_500, v0));
            assert!(arg0.current_phase > 20 - *0x2::table::borrow<address, u64>(&arg0.whitelist_500, v0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 250000 * 1000000000), arg2), v0);
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_500, v0);
            *v1 = *v1 - 1;
        } else if (arg1 == 300) {
            assert!(arg0.current_phase > 20 - *0x2::table::borrow<address, u64>(&arg0.whitelist_300, v0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 150000 * 1000000000), arg2), v0);
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_300, v0);
            *v2 = *v2 - 1;
        } else if (arg1 == 200) {
            assert!(arg0.current_phase > 20 - *0x2::table::borrow<address, u64>(&arg0.whitelist_200, v0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 100000 * 1000000000), arg2), v0);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_200, v0);
            *v3 = *v3 - 1;
        } else if (arg1 == 100) {
            assert!(arg0.current_phase > 10 - *0x2::table::borrow<address, u64>(&arg0.whitelist_100, v0), 5);
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_100, v0);
            *v4 = *v4 - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 50000 * 1000000000), arg2), v0);
        } else if (arg1 == 50) {
            assert!(arg0.current_phase > 10 - *0x2::table::borrow<address, u64>(&arg0.whitelist_50, v0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 50000 * 1000000000), arg2), v0);
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_50, v0);
            *v5 = *v5 - 1;
        } else if (arg1 == 20) {
            assert!(arg0.current_phase > 10 - *0x2::table::borrow<address, u64>(&arg0.whitelist_20, v0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 20000 * 1000000000), arg2), v0);
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_20, v0);
            *v6 = *v6 - 1;
        } else if (arg1 == 10) {
            assert!(arg0.current_phase > 1 - *0x2::table::borrow<address, u64>(&arg0.whitelist_10, v0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>>(0x2::coin::from_balance<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(0x2::balance::split<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 100000 * 1000000000), arg2), v0);
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_10, v0);
            *v7 = *v7 - 1;
        };
    }

    public fun get_current_phase(arg0: &FounderTeamGlobal) : u64 {
        arg0.current_phase
    }

    public entry fun get_total_shui_balance(arg0: &FounderTeamGlobal) : u64 {
        0x2::balance::value<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&arg0.balance_SHUI)
    }

    public fun increment(arg0: &mut FounderTeamGlobal, arg1: u64) {
        assert!(arg0.version == 0, 6);
        arg0.version = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FounderTeamGlobal{
            id               : 0x2::object::new(arg0),
            phase_start_time : 0,
            current_phase    : 0,
            creator          : 0x2::tx_context::sender(arg0),
            balance_SHUI     : 0x2::balance::zero<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(),
            whitelist_500    : 0x2::table::new<address, u64>(arg0),
            whitelist_300    : 0x2::table::new<address, u64>(arg0),
            whitelist_200    : 0x2::table::new<address, u64>(arg0),
            whitelist_100    : 0x2::table::new<address, u64>(arg0),
            whitelist_50     : 0x2::table::new<address, u64>(arg0),
            whitelist_20     : 0x2::table::new<address, u64>(arg0),
            whitelist_10     : 0x2::table::new<address, u64>(arg0),
            address_set      : 0x2::table::new<address, u64>(arg0),
            version          : 0,
        };
        0x2::transfer::share_object<FounderTeamGlobal>(v0);
    }

    public fun init_funds_from_main_contract(arg0: &mut FounderTeamGlobal, arg1: &mut 0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::SHUI>(&mut arg0.balance_SHUI, 0x4a0b0f395155c948c995aa0accdd11f3680cacd6057fb0b930ca56a59906fd60::shui::extract_founder_reserve_balance(arg1, arg2));
    }

    public entry fun next_phase(arg0: &mut FounderTeamGlobal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 6);
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        if (arg0.current_phase == 0) {
            arg0.phase_start_time = 0x2::clock::timestamp_ms(arg1);
            arg0.current_phase = arg0.current_phase + 1;
        } else {
            assert!((0x2::clock::timestamp_ms(arg1) - arg0.phase_start_time) / 30 * 86400000 + 1 >= 30, 4);
            arg0.phase_start_time = 0x2::clock::timestamp_ms(arg1);
            arg0.current_phase = arg0.current_phase + 1;
        };
    }

    // decompiled from Move bytecode v6
}

