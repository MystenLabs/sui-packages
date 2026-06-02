module 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin_entry {
    public entry fun migrate(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobalAdminCap) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::migrate(arg0, arg1);
    }

    public entry fun set_global_paused(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobalAdminCap, arg2: bool) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::set_global_paused(arg0, arg2, arg1);
    }

    public entry fun add_keeper<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::add_keeper<T0, T1>(arg1, arg4, arg2, arg3);
    }

    public entry fun add_protocol<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::add_protocol<T0, T1>(arg1, arg4, arg2, arg3);
        if (arg2 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_ALPHALEND()) {
            let v0 = alphalend_min_deposit_floor<T0, T1>(arg1);
            set_protocol_min_deposit_internal<T0, T1>(arg1, arg4, arg2, v0, arg3);
        };
    }

    public entry fun admin_reseed_empty_pool<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(!0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::is_global_paused(arg0), 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::assert_pool_admin<T0, T1>(arg1, 0x2::tx_context::sender(arg4));
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::assert_no_operation_in_progress<T0, T1>(arg1);
        let v0 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::real_share_supply<T0, T1>(arg1);
        let v1 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_real_shares_guard<T0, T1>(arg1);
        assert!(v0 < v1, 150);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::refresh_idle_balance<T0, T1>(arg1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_total_assets<T0, T1>(arg1);
        assert!(v4 > 0, 150);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::accrue_fees<T0, T1>(arg1, v4, v3);
        let v5 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::total_shares<T0, T1>(arg1);
        let v6 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_math::calculate_shares(v5, v4, v2);
        assert!(v6 > 0, 151);
        assert!(v6 >= 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_shares<T0, T1>(arg1), 151);
        let v7 = v0 + v6;
        assert!(v7 >= v1, 151);
        assert!(v6 <= 18446744073709551615, 152);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::deposit_idle_balance_internal<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg2));
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::update_last_total_assets<T0, T1>(arg1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::share_treasury_mut<T0, T1>(arg1), (v6 as u64), arg4), 0x2::tx_context::sender(arg4));
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_reseeded(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x2::tx_context::sender(arg4), v2, v6, v0, v7, v3);
    }

    fun alphalend_min_deposit_floor<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>) : u64 {
        default_alphalend_min_deposit_underlying<T0, T1>(arg0)
    }

    fun assert_protocol_min_deposit_allowed<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u64) {
        if (arg1 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_ALPHALEND()) {
            assert!(arg2 >= alphalend_min_deposit_floor<T0, T1>(arg0), 10);
        };
    }

    fun assert_required_ids(arg0: u8, arg1: &vector<address>) {
        if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_VAULT()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
        } else if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_SUILEND()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
        } else if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_SCALLOP()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
        } else if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_NAVI()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 4) != @0x0, 120);
        } else if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_CETUS()) {
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 1) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 2) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 3) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 4) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 5) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 6) != @0x0, 120);
            assert!(*0x1::vector::borrow<address>(arg1, 7) != @0x0, 120);
        } else {
            assert!(arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_ALPHALEND(), 120);
            assert!(*0x1::vector::borrow<address>(arg1, 0) != @0x0, 120);
        };
    }

    public entry fun bind_navi_reward_fund<T0, T1, T2>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::upsert_protocol_typed_id<T0, T1>(arg1, arg3, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_NAVI(), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>())), 0x2::object::id_from_address(arg2));
    }

    public entry fun claim_fee_shares<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::claim_fee_shares<T0, T1>(arg1, v0, arg3, arg2);
        let v3 = v1;
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_fee_shares_claimed(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), v0, (0x2::coin::value<T1>(&v3) as u128), v2, 0x2::clock::timestamp_ms(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public entry fun configure_protocol<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: vector<address>, arg4: vector<u64>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        let (v0, v1) = expected_config_lengths(arg2);
        assert!(0x1::vector::length<address>(&arg3) == v0, 120);
        let v2 = 0x1::vector::length<u64>(&arg4);
        if (arg2 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_CETUS()) {
            assert!(v2 <= 2, 120);
            if (v2 == 2) {
                assert!(*0x1::vector::borrow<u64>(&arg4, 1) <= 10000, 120);
            };
        } else {
            assert!(v2 == v1, 120);
        };
        assert_required_ids(arg2, &arg3);
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id<0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>>(arg1));
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg3)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg3, v4)));
            v4 = v4 + 1;
        };
        let v5 = 0x2::vec_map::empty<u8, vector<u8>>();
        0x2::vec_map::insert<u8, vector<u8>>(&mut v5, 0, arg5);
        0x2::vec_map::insert<u8, vector<u8>>(&mut v5, 1, arg6);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_protocol_config<T0, T1>(arg1, arg8, arg2, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::create_config(v3, arg4, v5), arg7);
    }

    public entry fun create_and_share_pool<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobalAdminCap, arg2: 0x1::string::String, arg3: address, arg4: 0x2::coin::TreasuryCap<T1>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::share_pool<T0, T1>(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::create_pool<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    fun default_alphalend_min_deposit_underlying<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>) : u64 {
        0x1::u64::pow(10, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::asset_decimals<T0, T1>(arg0))
    }

    fun expected_config_lengths(arg0: u8) : (u64, u64) {
        if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_VAULT()) {
            (2, 0)
        } else {
            let (v2, v3) = if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_SUILEND()) {
                (1, 2)
            } else {
                let (v4, v5) = if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_SCALLOP()) {
                    (4, 0)
                } else if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_NAVI()) {
                    (5, 1)
                } else if (arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_CETUS()) {
                    (8, 0)
                } else {
                    assert!(arg0 == 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_ALPHALEND(), 120);
                    (1, 1)
                };
                (v5, v4)
            };
            (v3, v2)
        }
    }

    public entry fun grant_pool_admin<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::grant_pool_admin<T0, T1>(arg1, arg3, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_pool_admin_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), arg2, 0x2::tx_context::sender(arg3), true, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_acl_role<T0, T1>(arg1, arg2), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_acl_role<T0, T1>(arg1, arg2));
    }

    public entry fun inject_reward_to_idle<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::inject_reward_to_idle<T0, T1>(arg1, arg4, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_reward_injected(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x2::coin::value<T0>(&arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun pause<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::pause<T0, T1>(arg1, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_pool_paused(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), true, 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun remove_keeper<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::remove_keeper<T0, T1>(arg1, arg4, arg2, arg3);
    }

    public entry fun revoke_pool_admin<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::revoke_pool_admin<T0, T1>(arg1, arg3, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_pool_admin_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), arg2, 0x2::tx_context::sender(arg3), false, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_acl_role<T0, T1>(arg1, arg2), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_acl_role<T0, T1>(arg1, arg2));
    }

    public entry fun set_deposit_cap<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_deposit_cap<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_deposit_cap_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_deposit_cap<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_fee_recipient<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_fee_recipient<T0, T1>(arg1, arg4, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_fee_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_management_fee<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        if (arg2 > 0) {
            0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::assert_fee_recipient_set<T0, T1>(arg1);
        };
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_management_fee<T0, T1>(arg1, arg4, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_fee_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_max_accounted_value_gap_bps<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(arg2 > 0 && arg2 <= 100, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_max_accounted_value_gap_bps<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_max_accounted_value_gap_bps(), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_max_accounted_value_gap_bps<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_max_balance_age_ms<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(arg2 > 0, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_max_balance_age_ms<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_max_balance_age_ms(), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_max_balance_age_ms<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_max_sync_deviation_bps<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(arg2 > 0 && arg2 <= 500, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_max_sync_deviation_bps<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_max_sync_deviation_bps(), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_max_sync_deviation_bps<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_min_deposit<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(arg2 > 0, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_min_deposit<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_min_deposit(), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_deposit<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_min_real_shares_guard<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(arg2 >= 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::min_shares_floor(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::asset_decimals<T0, T1>(arg1)), 10);
        assert!(arg2 <= 18446744073709551615, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_min_real_shares_guard<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_min_real_shares_guard(), (0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_real_shares_guard<T0, T1>(arg1) as u64), (arg2 as u64), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_min_rebalance_deviation<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_min_rebalance_deviation<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_min_rebalance_deviation(), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_rebalance_deviation_bps<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_min_rebalance_interval<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_min_rebalance_interval<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_min_rebalance_interval(), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_rebalance_interval_ms<T0, T1>(arg1), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_min_shares<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        assert!(arg2 > 0, 10);
        assert!(arg2 >= 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::min_shares_floor(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::asset_decimals<T0, T1>(arg1)), 10);
        assert!(arg2 <= 18446744073709551615, 10);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_min_shares<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_min_shares(), (0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_min_shares<T0, T1>(arg1) as u64), (arg2 as u64), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_name<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_name<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_admin_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::config_type_name(), 0, 0, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_performance_fee<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        if (arg2 > 0) {
            0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::assert_fee_recipient_set<T0, T1>(arg1);
        };
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_performance_fee<T0, T1>(arg1, arg4, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_fee_config_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 1, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_protocol_authorized_auth_type<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_protocol_authorized_auth_type<T0, T1>(arg1, arg5, arg2, arg3, arg4);
    }

    public entry fun set_protocol_deposit_cap<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_protocol_deposit_cap<T0, T1>(arg1, arg5, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_protocol_deposit_cap_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), arg2, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_protocol_deposit_cap<T0, T1>(arg1, arg2), arg3, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_protocol_balance<T0, T1>(arg1, arg2), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_protocol_min_deposit<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        set_protocol_min_deposit_internal<T0, T1>(arg1, arg5, arg2, arg3, arg4);
    }

    fun set_protocol_min_deposit_internal<T0, T1>(arg0: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_protocol_min_deposit_allowed<T0, T1>(arg0, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_protocol_min_deposit<T0, T1>(arg0, arg1, arg2, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_protocol_min_deposit_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg0), arg2, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_protocol_min_deposit<T0, T1>(arg0, arg2), arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun set_protocol_status<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: u8, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_protocol_status<T0, T1>(arg1, arg6, arg2, arg3, arg4, arg5);
    }

    public entry fun set_protocol_targets<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<bool>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_protocol_targets<T0, T1>(arg1, arg8, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun set_supply_queue<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_supply_queue<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_queue_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_supply_queue<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun set_targets_and_queues<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<bool>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_targets_and_queues<T0, T1>(arg1, arg10, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_queue_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 0, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_supply_queue<T0, T1>(arg1), v0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_queue_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_withdraw_queue<T0, T1>(arg1), v0);
    }

    public entry fun set_withdraw_queue<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::set_withdraw_queue<T0, T1>(arg1, arg4, arg2);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_queue_updated(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), 1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::get_withdraw_queue<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun unpause<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::unpause<T0, T1>(arg1, arg3);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_events::emit_pool_paused(0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::id<T0, T1>(arg1), false, 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

