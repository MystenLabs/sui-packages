module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin_entry {
    public entry fun migrate(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::migrate(arg0, arg1);
    }

    public entry fun set_global_paused(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::set_global_paused(arg0, arg1, arg2);
    }

    public entry fun set_owner(arg0: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::set_owner(arg0, arg1, arg2);
    }

    public entry fun add_keeper<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: address, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::add_keeper<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public entry fun add_protocol<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::add_protocol<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun assert_required_ids(arg0: u8, arg1: &vector<address>) {
        if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_VAULT()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
        } else if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
        } else if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SCALLOP()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
        } else if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 4) != @0x0, 120);
        } else if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 4) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 5) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 6) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 7) != @0x0, 120);
        } else {
            assert!(arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 120);
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
        };
    }

    public entry fun claim_fee_shares<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::claim_fee_shares<T0, T1>(arg1, v0, arg3, arg2);
        let v3 = v1;
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_fee_shares_claimed(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), v0, (0x2::coin::value<T1>(&v3) as u128), v2, 0x2::clock::timestamp_ms(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public entry fun configure_protocol<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        let (v0, v1) = expected_config_lengths(arg3);
        assert!(0x1::vector::length<address>(&arg4) == v0, 120);
        let v2 = 0x1::vector::length<u64>(&arg5);
        if (arg3 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS()) {
            assert!(v2 == 0 || v2 == 1, 120);
        } else {
            assert!(v2 == v1, 120);
        };
        assert_required_ids(arg3, &arg4);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>>(arg1));
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg4)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg4, v4)));
            v4 = v4 + 1;
        };
        let v5 = 0x2::vec_map::empty<u8, vector<u8>>();
        0x2::vec_map::insert<u8, vector<u8>>(&mut v5, 0, arg6);
        0x2::vec_map::insert<u8, vector<u8>>(&mut v5, 1, arg7);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_protocol_config<T0, T1>(arg1, arg2, arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::create_config(v3, arg5, v5), arg8);
    }

    public entry fun create_and_share_pool<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobalAdminCap, arg2: 0x1::string::String, arg3: 0x2::coin::TreasuryCap<T1>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        let (v0, v1) = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::create_pool<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::share_pool<T0, T1>(v0);
        0x2::transfer::public_transfer<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap>(v1, 0x2::tx_context::sender(arg6));
    }

    fun expected_config_lengths(arg0: u8) : (u64, u64) {
        if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_VAULT()) {
            (2, 0)
        } else {
            let (v2, v3) = if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SUILEND()) {
                (1, 2)
            } else {
                let (v4, v5) = if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_SCALLOP()) {
                    (4, 0)
                } else if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_NAVI()) {
                    (5, 1)
                } else if (arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_CETUS()) {
                    (8, 0)
                } else {
                    assert!(arg0 == 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_ALPHALEND(), 120);
                    (1, 1)
                };
                (v5, v4)
            };
            (v3, v2)
        }
    }

    public entry fun inject_reward_to_idle<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::inject_reward_to_idle<T0, T1>(arg1, arg2, arg3, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_reward_injected(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 0x2::coin::value<T0>(&arg3), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun pause<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::pause<T0, T1>(arg1, arg2);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_pool_paused(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), true, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun remove_keeper<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: address, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::remove_keeper<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public entry fun set_degraded_withdraw_mode<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: bool) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_degraded_withdraw_mode<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_deposit_cap<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u128, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_deposit_cap<T0, T1>(arg1, arg2, arg3);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_deposit_cap_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_deposit_cap<T0, T1>(arg1), arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_fee_recipient<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: address, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_fee_recipient<T0, T1>(arg1, arg2, arg3, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_fee_config_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 0, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_management_fee<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_management_fee<T0, T1>(arg1, arg2, arg3, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_fee_config_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 2, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_max_balance_age_ms<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_max_balance_age_ms<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_min_deposit<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_min_deposit<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_min_rebalance_deviation<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_min_rebalance_deviation<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_min_rebalance_interval<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_min_rebalance_interval<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_name<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: 0x1::string::String) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_name<T0, T1>(arg1, arg2, arg3);
    }

    public entry fun set_performance_fee<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_performance_fee<T0, T1>(arg1, arg2, arg3, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_fee_config_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 1, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_protocol_authorized_auth_type<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_protocol_authorized_auth_type<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_protocol_deposit_cap<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_protocol_deposit_cap<T0, T1>(arg1, arg2, arg3, arg4);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_protocol_deposit_cap_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), arg3, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_deposit_cap<T0, T1>(arg1, arg3), arg4, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_protocol_balance<T0, T1>(arg1, arg3), 0x2::clock::timestamp_ms(arg5));
    }

    public entry fun set_protocol_status<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_protocol_status<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_protocol_targets<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u128>, arg6: vector<bool>, arg7: vector<bool>, arg8: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_protocol_targets<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun set_supply_queue<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_supply_queue<T0, T1>(arg1, arg2, arg3);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_queue_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_supply_queue<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_withdraw_queue<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::set_withdraw_queue<T0, T1>(arg1, arg2, arg3);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_queue_updated(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), 1, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::get_withdraw_queue<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun unpause<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::unpause<T0, T1>(arg1, arg2);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_pool_paused(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::id<T0, T1>(arg1), false, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun update_apr<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::update_apr<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun update_aprs<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobal, arg1: &mut 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::LLVPool<T0, T1>, arg2: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg3: vector<u8>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::assert_version(arg0);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 10);
        let v1 = 0;
        while (v1 < v0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool::update_apr<T0, T1>(arg1, arg2, *0x1::vector::borrow<u8>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

