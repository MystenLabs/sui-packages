module 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::migration {
    struct LPLock has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        creator: address,
        locked_until: u64,
        amount: u64,
    }

    public fun complete_migration<T0>(arg0: &mut 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::TokenLaunch<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::can_migrate<T0>(arg0), 200);
        assert!(!0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::is_migrated<T0>(arg0), 201);
        assert!(0x2::tx_context::sender(arg2) == 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::get_creator<T0>(arg0), 202);
        0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::mark_migrated<T0>(arg0, arg1, arg2);
    }

    public fun get_lock_info(arg0: &LPLock) : (0x2::object::ID, address, u64, u64) {
        (arg0.launch_id, arg0.creator, arg0.locked_until, arg0.amount)
    }

    public fun is_lock_expired(arg0: &LPLock, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.locked_until
    }

    public fun lock_lp_tokens(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : LPLock {
        LPLock{
            id           : 0x2::object::new(arg5),
            launch_id    : arg0,
            creator      : arg1,
            locked_until : 0x2::clock::timestamp_ms(arg4) + arg3 * 24 * 60 * 60 * 1000,
            amount       : arg2,
        }
    }

    public fun prepare_migration<T0>(arg0: &mut 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::TokenLaunch<T0>, arg1: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        assert!(0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::can_migrate<T0>(arg0), 200);
        assert!(!0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::is_migrated<T0>(arg0), 201);
        assert!(0x2::tx_context::sender(arg1) == 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::get_creator<T0>(arg0), 202);
        let v0 = 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::get_config<T0>(arg0);
        (0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::extract_sui_for_migration<T0>(arg0, arg1), 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::get_tokens_sold<T0>(arg0) * (0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::bonding_curve::config_migration_percent(&v0) as u64) / 100)
    }

    public fun share_lock(arg0: LPLock) {
        0x2::transfer::share_object<LPLock>(arg0);
    }

    // decompiled from Move bytecode v6
}

