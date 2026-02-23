module 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin_entry {
    public entry fun migrate(arg0: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &0x2::tx_context::TxContext) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::migrate(arg0, arg1);
    }

    public entry fun set_global_paused(arg0: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::set_global_paused(arg0, arg1, arg2);
    }

    public entry fun set_owner(arg0: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::set_owner(arg0, arg1, arg2);
    }

    public entry fun add_keeper<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: address, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::add_keeper<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun add_protocol<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::add_protocol<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun assert_required_ids(arg0: u8, arg1: &vector<address>) {
        if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_VAULT()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
        } else if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_SUILEND()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
        } else if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_SCALLOP()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
        } else if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_NAVI()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 4) != @0x0, 120);
        } else {
            assert!(arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_CETUS(), 120);
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 4) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 5) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 6) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 7) != @0x0, 120);
        };
    }

    public entry fun claim_fee_shares<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::claim_fee_shares<T0>(arg1, v0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_fee_shares_claimed(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), v0, v1, v2, 0x2::clock::timestamp_ms(arg2));
        0x2::transfer::public_transfer<0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_position::LLVPoolPosition<T0>>(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_position::create<T0>(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), v1, v2, 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::global_yield_index<T0>(arg1), arg3), v0);
    }

    public entry fun configure_protocol<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        let (v0, v1) = expected_config_lengths(arg3);
        assert!(0x1::vector::length<address>(&arg4) == v0, 120);
        assert!(0x1::vector::length<u64>(&arg5) == v1, 120);
        assert_required_ids(arg3, &arg4);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>>(arg1));
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg4)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg4, v3)));
            v3 = v3 + 1;
        };
        let v4 = 0x2::vec_map::empty<u8, vector<u8>>();
        0x2::vec_map::insert<u8, vector<u8>>(&mut v4, 0, arg6);
        0x2::vec_map::insert<u8, vector<u8>>(&mut v4, 1, arg7);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_protocol_config<T0>(arg1, arg2, arg3, 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::create_config(v2, arg5, v4), arg8);
    }

    public entry fun create_and_share_pool<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobalAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_pool<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_share_object<0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>>(v0);
        0x2::transfer::public_transfer<0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun create_pool<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobalAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::create_pool<T0>(arg1, arg2, arg3)
    }

    public entry fun emergency_clear_protocol_balance<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_protocol_removed(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), arg3, 0x2::clock::timestamp_ms(arg4));
    }

    fun expected_config_lengths(arg0: u8) : (u64, u64) {
        let (v0, v1) = if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_VAULT()) {
            (0, 2)
        } else {
            let (v2, v3) = if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_SUILEND()) {
                (1, 1)
            } else if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_SCALLOP()) {
                (2, 0)
            } else if (arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_NAVI()) {
                (5, 1)
            } else {
                assert!(arg0 == 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_allocation_plan::PROTOCOL_CETUS(), 120);
                (8, 0)
            };
            (v3, v2)
        };
        (v1, v0)
    }

    public entry fun init_navi_account<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::verify_pool_admin(arg2, 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1));
        0x2::dynamic_field::add<0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::borrow_uid_mut<T0>(arg1), 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::navi_account_cap_key(), arg3);
    }

    public entry fun pause<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::pause<T0>(arg1, arg2);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_pool_paused(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), true, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun remove_keeper<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: address, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::remove_keeper<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun remove_protocol<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::remove_protocol<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun set_deposit_cap<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u128, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_deposit_cap<T0>(arg1, arg2, arg3);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_deposit_cap_updated(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::get_deposit_cap<T0>(arg1), arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_fee_recipient<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: address, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_fee_recipient<T0>(arg1, arg2, arg3);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_fee_config_updated(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), 0, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_management_fee<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_management_fee<T0>(arg1, arg2, arg3);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_fee_config_updated(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), 2, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_min_deposit<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_min_deposit<T0>(arg1, arg2, arg3);
    }

    public entry fun set_min_rebalance_deviation<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_min_rebalance_deviation<T0>(arg1, arg2, arg3);
    }

    public entry fun set_min_rebalance_interval<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_min_rebalance_interval<T0>(arg1, arg2, arg3);
    }

    public entry fun set_performance_fee<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_performance_fee<T0>(arg1, arg2, arg3);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_fee_config_updated(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), 1, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_supply_queue<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_supply_queue<T0>(arg1, arg2, arg3);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_queue_updated(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), 0, 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::get_supply_queue<T0>(arg1), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_withdraw_queue<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::set_withdraw_queue<T0>(arg1, arg2, arg3);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_queue_updated(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), 1, 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::get_withdraw_queue<T0>(arg1), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun sync_all_balances<T0, T1, T2>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<0x2::sui::SUI>, arg2: &0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg3: &0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::market::Hearn, arg4: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg6: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg7: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg10: u8, arg11: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_validation::validate_all_for_sync(arg1, 0x2::object::id<0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::meta_vault_core::Vault<0x2::sui::SUI, T0>>(arg2), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg5), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg6), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg7), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg8), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg9), arg10);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_protocol_ops::sync_all_balances<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun sync_l1_l3_balances<T0, T1, T2>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::meta_vault_core::Vault<T0, T1>, arg3: &0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::market::Hearn, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_validation::validate_l1_l3_for_sync<T0>(arg1, 0x2::object::id<0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::meta_vault_core::Vault<T0, T1>>(arg2), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg4), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg5), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg6), arg7);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_protocol_ops::sync_l1_l3_balances<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun unpause<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::unpause<T0>(arg1, arg2);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_events::emit_pool_paused(0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::id<T0>(arg1), false, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun update_apr<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::update_apr<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun update_aprs<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 10);
        let v1 = 0;
        while (v1 < v0) {
            0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::update_apr<T0>(arg1, arg2, *0x1::vector::borrow<u8>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    public entry fun update_protocol<T0>(arg0: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVGlobal, arg1: &mut 0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::LLVPool<T0>, arg2: &0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) {
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_admin::assert_version(arg0);
        0xd6bb2ff073a082ef8408d598b05c42aa3c5ddd0d393e353d8589433c01733a41::llv_pool::update_protocol<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

