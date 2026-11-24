module 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::migration {
    struct Migration<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        source: 0x2::object::ID,
        target: 0x2::object::ID,
        cut_ms: u64,
        checkpoint: u64,
        expected: u64,
        moved: u64,
        quarantined: u64,
        quarantine_recipient: address,
        paused: bool,
        admin: 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap,
        importer: 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::MigrationImportCap,
        governor: address,
        controller: address,
        context_hash: vector<u8>,
        root: vector<u8>,
    }

    struct RetiredAdmin has key {
        id: 0x2::object::UID,
        cap: 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap,
    }

    struct Row has drop {
        migration: 0x2::object::ID,
        source: 0x2::object::ID,
        target: 0x2::object::ID,
        cut_ms: u64,
        checkpoint: u64,
        context_hash: vector<u8>,
        token: 0x2::object::ID,
        owner: address,
        principal: u64,
        decaying: bool,
        time_field: u64,
    }

    struct PositionMapped has copy, drop {
        migration: 0x2::object::ID,
        token: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
    }

    struct Began has copy, drop {
        migration: 0x2::object::ID,
        source: 0x2::object::ID,
        target: 0x2::object::ID,
        expected: u64,
        cut_ms: u64,
    }

    struct Approved has copy, drop {
        migration: 0x2::object::ID,
        checkpoint: u64,
        root: vector<u8>,
    }

    struct Finished has copy, drop {
        migration: 0x2::object::ID,
        target: 0x2::object::ID,
        moved: u64,
        quarantined: u64,
    }

    struct Quarantined has copy, drop {
        migration: 0x2::object::ID,
        token: 0x2::object::ID,
        owner: address,
        principal: u64,
        recipient: address,
    }

    struct Cancelled has copy, drop {
        migration: 0x2::object::ID,
        source: 0x2::object::ID,
    }

    struct Moved has copy, drop {
        migration: 0x2::object::ID,
        token: 0x2::object::ID,
        owner: address,
        principal: u64,
        active: u64,
    }

    struct ControllerChanged has copy, drop {
        migration: 0x2::object::ID,
        governor: address,
        controller: address,
    }

    struct PauseChanged has copy, drop {
        migration: 0x2::object::ID,
        paused: bool,
    }

    public fun approve<T0>(arg0: &mut Migration<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = if (arg0.controller == 0x2::tx_context::sender(arg4)) {
            if (arg0.moved == 0) {
                if (arg0.quarantined == 0) {
                    if (0x1::vector::length<u8>(&arg2) == 32) {
                        0x1::vector::length<u8>(&arg3) == 32
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg0.checkpoint = arg1;
        arg0.context_hash = arg2;
        let v1 = Approved{
            migration  : 0x2::object::id<Migration<T0>>(arg0),
            checkpoint : arg1,
            root       : arg3,
        };
        0x2::event::emit<Approved>(v1);
        arg0.root = arg3;
    }

    fun assert_version<T0>(arg0: &Migration<T0>) {
        assert!(arg0.version == 1, 13835621808394731525);
    }

    public fun begin<T0>(arg0: 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap, arg1: 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::MigrationImportCap, arg2: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg3: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        begin_with_controller<T0>(arg0, arg1, arg2, arg3, v0, arg4, arg5);
    }

    fun begin_internal<T0>(arg0: 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap, arg1: 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::MigrationImportCap, arg2: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg3: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 != @0x0, 1);
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::begin_epochs<T0>(&arg1, arg3, 0x2::object::id<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>>(arg2), arg6);
        let v0 = 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::freeze_export<T0>(arg2);
        let v1 = 0x2::object::new(arg7);
        let v2 = Began{
            migration : 0x2::object::uid_to_inner(&v1),
            source    : 0x2::object::id<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>>(arg2),
            target    : 0x2::object::id<0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>>(arg3),
            expected  : v0,
            cut_ms    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<Began>(v2);
        let v3 = ControllerChanged{
            migration  : 0x2::object::uid_to_inner(&v1),
            governor   : 0x2::tx_context::sender(arg7),
            controller : arg4,
        };
        0x2::event::emit<ControllerChanged>(v3);
        let v4 = Migration<T0>{
            id                   : v1,
            version              : 1,
            source               : 0x2::object::id<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>>(arg2),
            target               : 0x2::object::id<0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>>(arg3),
            cut_ms               : 0x2::clock::timestamp_ms(arg6),
            checkpoint           : 0,
            expected             : v0,
            moved                : 0,
            quarantined          : 0,
            quarantine_recipient : arg5,
            paused               : false,
            admin                : arg0,
            importer             : arg1,
            governor             : 0x2::tx_context::sender(arg7),
            controller           : arg4,
            context_hash         : b"",
            root                 : b"",
        };
        0x2::transfer::share_object<Migration<T0>>(v4);
    }

    public fun begin_with_controller<T0>(arg0: 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap, arg1: 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::MigrationImportCap, arg2: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg3: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        begin_internal<T0>(arg0, arg1, arg2, arg3, arg4, @0x0, arg5, arg6);
    }

    public fun begin_with_quarantine<T0>(arg0: 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap, arg1: 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::MigrationImportCap, arg2: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg3: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 != @0x0 && arg5 != 0x2::tx_context::sender(arg7), 1);
        begin_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun cancel<T0>(arg0: Migration<T0>, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(&arg0);
        let Migration {
            id                   : v0,
            version              : _,
            source               : v2,
            target               : _,
            cut_ms               : _,
            checkpoint           : _,
            expected             : _,
            moved                : v7,
            quarantined          : v8,
            quarantine_recipient : _,
            paused               : _,
            admin                : v11,
            importer             : v12,
            governor             : v13,
            controller           : v14,
            context_hash         : _,
            root                 : _,
        } = arg0;
        let v17 = v12;
        let v18 = v0;
        let v19 = if (0x2::tx_context::sender(arg3) == v14) {
            if (0x2::object::id<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>>(arg1) == v2) {
                if (v7 == 0) {
                    v8 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v19, 1);
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::cancel_epochs<T0>(&v17, arg2, v2);
        0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::update_version<T0>(arg1);
        let v20 = Cancelled{
            migration : 0x2::object::uid_to_inner(&v18),
            source    : v2,
        };
        0x2::event::emit<Cancelled>(v20);
        0x2::object::delete(v18);
        0x2::transfer::public_transfer<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap>(v11, v13);
        0x2::transfer::public_transfer<0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::MigrationImportCap>(v17, v13);
    }

    public fun finish<T0>(arg0: Migration<T0>, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(&arg0);
        assert!(!arg0.paused, 13835903974861307911);
        let Migration {
            id                   : v0,
            version              : _,
            source               : v2,
            target               : v3,
            cut_ms               : v4,
            checkpoint           : _,
            expected             : v6,
            moved                : v7,
            quarantined          : v8,
            quarantine_recipient : _,
            paused               : _,
            admin                : v11,
            importer             : v12,
            governor             : v13,
            controller           : v14,
            context_hash         : v15,
            root                 : v16,
        } = arg0;
        let v17 = v16;
        let v18 = v0;
        let v19 = if (v14 == 0x2::tx_context::sender(arg3)) {
            if (v2 == 0x2::object::id<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>>(arg1)) {
                if (v3 == 0x2::object::id<0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>>(arg2)) {
                    if (0x1::vector::length<u8>(&v17) == 32) {
                        v7 + v8 == v6
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v19, 1);
        0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::finish_export<T0>(arg1);
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::open<T0>(v12, arg2, v2, v7, v4, v17, v15);
        let v20 = Finished{
            migration   : 0x2::object::uid_to_inner(&v18),
            target      : v3,
            moved       : v7,
            quarantined : v8,
        };
        0x2::event::emit<Finished>(v20);
        0x2::object::delete(v18);
        0x2::transfer::public_transfer<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::admin::AdminCap>(v11, v13);
    }

    public fun migrate_version<T0>(arg0: &mut Migration<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.governor == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.version < 1, 13835621864229306373);
        arg0.version = 1;
    }

    public fun move_row<T0>(arg0: &mut Migration<T0>, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) {
        move_row_corrected<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, arg10);
    }

    public fun move_row_corrected<T0>(arg0: &mut Migration<T0>, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        verify_export<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, false);
        let v0 = if (arg6) {
            if (arg7 > arg0.cut_ms) {
                arg7 - arg0.cut_ms
            } else {
                0
            }
        } else {
            arg7 * 604800000
        };
        let v1 = if (v0 >= 1209600000) {
            arg5
        } else {
            0
        };
        let v2 = PositionMapped{
            migration : 0x2::object::id<Migration<T0>>(arg0),
            token     : arg3,
            position  : 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::import_position<T0>(&arg0.importer, arg2, arg0.source, arg4, 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::export<T0>(arg1, arg4, arg3, arg5, arg10), v1, arg11),
            owner     : arg4,
        };
        0x2::event::emit<PositionMapped>(v2);
        arg0.moved = arg0.moved + arg5;
        let v3 = Moved{
            migration : 0x2::object::id<Migration<T0>>(arg0),
            token     : arg3,
            owner     : arg4,
            principal : arg5,
            active    : v1,
        };
        0x2::event::emit<Moved>(v3);
    }

    public fun quarantine_row<T0>(arg0: &mut Migration<T0>, arg1: &mut 0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.quarantine_recipient != @0x0, 1);
        verify_export<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::export<T0>(arg1, arg4, arg3, arg5, arg10), arg11), arg0.quarantine_recipient);
        arg0.quarantined = arg0.quarantined + arg5;
        let v0 = Quarantined{
            migration : 0x2::object::id<Migration<T0>>(arg0),
            token     : arg3,
            owner     : arg4,
            principal : arg5,
            recipient : arg0.quarantine_recipient,
        };
        0x2::event::emit<Quarantined>(v0);
    }

    public fun row_digest<T0>(arg0: &Migration<T0>, arg1: u64, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: bool, arg7: u64) : vector<u8> {
        let v0 = Row{
            migration    : 0x2::object::id<Migration<T0>>(arg0),
            source       : arg0.source,
            target       : arg0.target,
            cut_ms       : arg0.cut_ms,
            checkpoint   : arg1,
            context_hash : arg2,
            token        : arg3,
            owner        : arg4,
            principal    : arg5,
            decaying     : arg6,
            time_field   : arg7,
        };
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::merkle_proof::leaf(1, 0x2::bcs::to_bytes<Row>(&v0))
    }

    public fun set_controller<T0>(arg0: &mut Migration<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.governor && arg1 != @0x0, 1);
        arg0.controller = arg1;
        let v0 = ControllerChanged{
            migration  : 0x2::object::id<Migration<T0>>(arg0),
            governor   : arg0.governor,
            controller : arg1,
        };
        0x2::event::emit<ControllerChanged>(v0);
    }

    public fun set_paused<T0>(arg0: &mut Migration<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.controller == 0x2::tx_context::sender(arg2), 0);
        arg0.paused = arg1;
        let v0 = PauseChanged{
            migration : 0x2::object::id<Migration<T0>>(arg0),
            paused    : arg1,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    fun verify_export<T0>(arg0: &Migration<T0>, arg1: &0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>, arg2: &0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: u64, arg11: bool) {
        assert_version<T0>(arg0);
        assert!(!arg0.paused, 13835903854602223623);
        assert!(arg0.source == 0x2::object::id<0x462e270491da3d2302b8f2a20c97f408dbc763c7c7fa88ea7a9015f9dea83b42::staking_pool::StakingPool<T0>>(arg1) && arg0.target == 0x2::object::id<0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking::Pool<T0>>(arg2), 1);
        let v0 = row_digest<T0>(arg0, arg0.checkpoint, arg0.context_hash, arg3, arg4, arg5, arg6, arg7);
        if (arg10 > 0) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg10));
            let v1 = v0;
            v0 = 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::merkle_proof::leaf(3, v1);
        };
        if (arg11) {
            let v2 = v0;
            v0 = 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::merkle_proof::leaf(4, v2);
        };
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::merkle_proof::verify(&arg0.root, v0, arg8, &arg9);
    }

    // decompiled from Move bytecode v7
}

