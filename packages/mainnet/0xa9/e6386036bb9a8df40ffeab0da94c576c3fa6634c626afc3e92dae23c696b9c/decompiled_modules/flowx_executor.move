module 0xa9e6386036bb9a8df40ffeab0da94c576c3fa6634c626afc3e92dae23c696b9c::flowx_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionKey has copy, drop, store {
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        fee_rate: u64,
        tick_lower: u32,
        tick_upper: u32,
        owner: 0x2::object::ID,
    }

    struct FlowXExecutorConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        operators: 0x2::vec_map::VecMap<address, bool>,
        position_key_ids: 0x2::table::Table<PositionKey, 0x2::object::ID>,
        position_id_keys: 0x2::table::Table<0x2::object::ID, PositionKey>,
        position_nfts: 0x2::bag::Bag,
        access_cap: 0x1::option::Option<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>,
        pool_ids: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
        allow_all_pools: bool,
    }

    struct SwapEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        input_amount: u64,
        output_amount: u64,
    }

    struct OpenPositionEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct ClosePositionEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct AddLiquidityEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        amount_token_a: u64,
        amount_token_b: u64,
        tick_lower: u32,
        tick_upper: u32,
        after_position_liquidity: u128,
        after_position_amount_token_a: u64,
        after_position_amount_token_b: u64,
    }

    struct RemoveLiquidityEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        amount_token_a: u64,
        amount_token_b: u64,
        after_position_liquidity: u128,
        after_position_amount_token_a: u64,
        after_position_amount_token_b: u64,
    }

    struct CollectRewardEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        reward_token_type: 0x1::type_name::TypeName,
        reward_token_amount: u64,
    }

    struct CollectFeeEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        amount_token_a: u64,
        amount_token_b: u64,
    }

    struct ChangeAdminEvent has copy, drop, store {
        new_owner: address,
    }

    struct AddOperatorEvent has copy, drop, store {
        operator: address,
    }

    struct RemoveOperatorEvent has copy, drop, store {
        operator: address,
    }

    struct AddPoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct RemovePoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    public entry fun swap<T0, T1, T2, T3>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert!(arg6 > 0, 1);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T2, T3>(arg1, arg5);
        assert_pool_exists(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(v0));
        let v1 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v2 = if (arg8) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg6, v1, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let v3 = v2;
        let v4 = if (arg8) {
            0x2::coin::zero<T3>(arg10)
        } else {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T3>(arg4, arg3, arg6, v1, arg10)
        };
        let v5 = v4;
        let v6 = &mut v3;
        let v7 = &mut v5;
        internal_swap<T0, T1, T2, T3>(arg0, v0, arg2, arg3, arg4, v6, v7, arg6, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<T2>(&v3) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v3, v1);
        } else {
            0x2::coin::destroy_zero<T2>(v3);
        };
        if (0x2::coin::value<T3>(&v5) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v5, v1);
        } else {
            0x2::coin::destroy_zero<T3>(v5);
        };
    }

    public entry fun close_position<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg5: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg6: u64, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg2, arg6));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg4);
        let v3 = 0x2::table::remove<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, arg7);
        assert!(v2 == v3.owner, 4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::close_position(arg1, 0x2::bag::remove<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg7), arg3, arg9);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::withdraw_lp<T0, T1>(arg5, arg4, v1, v0);
        let v4 = ClosePositionEvent<T2, T3>{
            vault_id   : v2,
            pool_id    : v1,
            lp_id      : arg7,
            tick_lower : v3.tick_lower,
            tick_upper : v3.tick_upper,
        };
        0x2::event::emit<ClosePositionEvent<T2, T3>>(v4);
        0x2::table::remove<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v3);
    }

    public entry fun open_position<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg5: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg6: u64, arg7: u32, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg2, arg6));
        assert_pool_exists(arg0, v0);
        get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg3, arg6, arg7, arg8, arg4, arg5, true, arg9);
    }

    public entry fun add_access_cap(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public entry fun add_liquidity<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg5: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg14));
        assert_version(arg0);
        assert!(arg9 > 0 || arg10 > 0, 3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg2, arg6));
        assert_pool_exists(arg0, v0);
        let v1 = get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg3, arg6, arg7, arg8, arg4, arg5, false, arg14);
        let v2 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v3 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T2>(arg5, arg4, arg9, v2, arg14);
        let v4 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T3>(arg5, arg4, arg10, v2, arg14);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::increase_liquidity_v2<T2, T3>(arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, v1), &mut v3, &mut v4, arg11, arg12, 0x2::clock::timestamp_ms(arg13) + 5000, arg3, arg13, arg14);
        let v5 = arg9;
        let v6 = arg10;
        if (0x2::coin::value<T2>(&v3) > 0) {
            v5 = arg9 - 0x2::coin::value<T2>(&v3);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, v3, v2);
        } else {
            0x2::coin::destroy_zero<T2>(v3);
        };
        if (0x2::coin::value<T3>(&v4) > 0) {
            v6 = arg10 - 0x2::coin::value<T3>(&v4);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T3>(arg5, arg4, v4, v2);
        } else {
            0x2::coin::destroy_zero<T3>(v4);
        };
        emit_event_add_liquidity<T2, T3>(arg0, v0, 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg4), v1, v5, v6, arg7, arg8);
    }

    public entry fun add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg5: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg14));
        assert_version(arg0);
        assert!(arg9 > 0 || arg10 > 0, 3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T2>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T2>(arg2, arg6));
        assert_pool_exists(arg0, v0);
        let v1 = get_or_create_position<T0, T1, T0, T2>(arg0, arg1, arg2, v0, arg3, arg6, arg7, arg8, arg4, arg5, false, arg14);
        let v2 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v3 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_vault_funds<T0, T1>(arg5, arg4, arg9, v2, arg14);
        let v4 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T2>(arg5, arg4, arg10, v2, arg14);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::increase_liquidity_v2<T0, T2>(arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, v1), &mut v3, &mut v4, arg11, arg12, 0x2::clock::timestamp_ms(arg13) + 5000, arg3, arg13, arg14);
        let v5 = arg9;
        let v6 = arg10;
        if (0x2::coin::value<T0>(&v3) > 0) {
            v5 = arg9 - 0x2::coin::value<T0>(&v3);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg4, v3, arg14);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T2>(&v4) > 0) {
            v6 = arg10 - 0x2::coin::value<T2>(&v4);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, v4, v2);
        } else {
            0x2::coin::destroy_zero<T2>(v4);
        };
        emit_event_add_liquidity<T0, T2>(arg0, v0, 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg4), v1, v5, v6, arg7, arg8);
    }

    public entry fun add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg5: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg14));
        assert_version(arg0);
        assert!(arg9 > 0 || arg10 > 0, 3);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T0>(arg2, arg6));
        assert_pool_exists(arg0, v0);
        let v1 = get_or_create_position<T0, T1, T2, T0>(arg0, arg1, arg2, v0, arg3, arg6, arg7, arg8, arg4, arg5, false, arg14);
        let v2 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v3 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T2>(arg5, arg4, arg9, v2, arg14);
        let v4 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_vault_funds<T0, T1>(arg5, arg4, arg10, v2, arg14);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::increase_liquidity_v2<T2, T0>(arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, v1), &mut v3, &mut v4, arg11, arg12, 0x2::clock::timestamp_ms(arg13) + 5000, arg3, arg13, arg14);
        let v5 = arg9;
        let v6 = arg10;
        if (0x2::coin::value<T2>(&v3) > 0) {
            v5 = arg9 - 0x2::coin::value<T2>(&v3);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, v3, v2);
        } else {
            0x2::coin::destroy_zero<T2>(v3);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            v6 = arg10 - 0x2::coin::value<T0>(&v4);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg4, v4, arg14);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        emit_event_add_liquidity<T2, T0>(arg0, v0, 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg4), v1, v5, v6, arg7, arg8);
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 5);
        0x2::vec_map::insert<address, bool>(&mut arg1.operators, arg2, true);
        let v0 = AddOperatorEvent{operator: arg2};
        0x2::event::emit<AddOperatorEvent>(v0);
    }

    public entry fun add_pool_id(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &arg2), 10);
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.pool_ids, arg2, true);
        let v0 = AddPoolEvent{pool_id: arg2};
        0x2::event::emit<AddPoolEvent>(v0);
    }

    public entry fun add_pool_ids(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (!0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &v1)) {
                0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.pool_ids, v1, true);
                let v2 = AddPoolEvent{pool_id: v1};
                0x2::event::emit<AddPoolEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun assert_is_operator(arg0: &FlowXExecutorConfig, arg1: address) {
        assert!(0x2::vec_map::contains<address, bool>(&arg0.operators, &arg1), 4);
    }

    public fun assert_pool_exists(arg0: &FlowXExecutorConfig, arg1: 0x2::object::ID) {
        assert!(arg0.allow_all_pools || 0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.pool_ids, &arg1), 11);
    }

    public fun assert_version(arg0: &FlowXExecutorConfig) {
        assert!(arg0.version == 1, 7);
    }

    public entry fun check_pool<T0, T1>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>) {
        assert_pool_exists(arg0, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(arg1));
    }

    public entry fun collect_fee<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg8));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let (v4, v5) = internal_collect_fee<T2, T3>(arg1, v1, arg2, v2, v3, arg6, arg7, arg8);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T2>(&v7) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v7, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        if (0x2::coin::value<T3>(&v6) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v6, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v6);
        };
    }

    public entry fun collect_fee_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg8));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T2>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T2>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let (v4, v5) = internal_collect_fee<T0, T2>(arg1, v1, arg2, v2, v3, arg6, arg7, arg8);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T0>(&v7) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v7, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v7);
        };
        if (0x2::coin::value<T2>(&v6) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v6, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v6);
        };
    }

    public entry fun collect_fee_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg8));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T0>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let (v4, v5) = internal_collect_fee<T2, T0>(arg1, v1, arg2, v2, v3, arg6, arg7, arg8);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T2>(&v7) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v7, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v6, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
    }

    public entry fun collect_reward<T0, T1, T2, T3, T4>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg8));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let v4 = internal_collect_reward<T2, T3, T4>(arg1, v1, arg2, v2, v3, arg6, arg7, arg8);
        if (0x2::coin::value<T4>(&v4) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T4>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T4>(v4);
        };
    }

    public entry fun collect_reward_have_reward_in_vault<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg8));
        assert_version(arg0);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg1, arg5));
        assert_pool_exists(arg0, v0);
        let v1 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let v3 = internal_collect_reward<T2, T3, T0>(arg1, v0, arg2, v1, v2, arg6, arg7, arg8);
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v3, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
    }

    fun emit_event_add_liquidity<T0, T1>(arg0: &FlowXExecutorConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u32, arg7: u32) {
        let (v0, v1) = get_position_amounts(arg0, arg3);
        let v2 = AddLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : arg1,
            lp_id                         : arg3,
            amount_token_a                : arg4,
            amount_token_b                : arg5,
            tick_lower                    : arg6,
            tick_upper                    : arg7,
            after_position_liquidity      : get_position_liquidity(arg0, arg3),
            after_position_amount_token_a : v0,
            after_position_amount_token_b : v1,
        };
        0x2::event::emit<AddLiquidityEvent<T0, T1>>(v2);
    }

    fun emit_event_remove_liquidity<T0, T1>(arg0: 0x2::object::ID, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = RemoveLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : arg0,
            lp_id                         : arg3,
            amount_token_a                : arg4,
            amount_token_b                : arg5,
            after_position_liquidity      : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(arg1),
            after_position_amount_token_a : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_x(arg1),
            after_position_amount_token_b : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_y(arg1),
        };
        0x2::event::emit<RemoveLiquidityEvent<T0, T1>>(v0);
    }

    fun get_or_create_position<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: 0x2::object::ID, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: u64, arg6: u32, arg7: u32, arg8: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg9: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2) = get_position_id<T2, T3>(arg0, 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg8), arg5, arg6, arg7, arg11);
        let v3 = v1;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            if (arg10) {
                let v6 = OpenPositionEvent<T2, T3>{
                    vault_id   : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg8),
                    pool_id    : arg3,
                    lp_id      : v5,
                    tick_lower : arg6,
                    tick_upper : arg7,
                };
                0x2::event::emit<OpenPositionEvent<T2, T3>>(v6);
            };
            v5
        } else {
            let v7 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::open_position<T2, T3>(arg1, arg2, arg5, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg6), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from_u32(arg7), arg4, arg11);
            let v8 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&v7);
            0x2::bag::add<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, v8, v7);
            0x2::table::add<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v2, v8);
            0x2::table::add<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, v8, v2);
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_lp<T0, T1>(arg9, arg8, arg3, v8, v0);
            let v9 = OpenPositionEvent<T2, T3>{
                vault_id   : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg8),
                pool_id    : arg3,
                lp_id      : v8,
                tick_lower : arg6,
                tick_upper : arg7,
            };
            0x2::event::emit<OpenPositionEvent<T2, T3>>(v9);
            v8
        }
    }

    public entry fun get_pool_id<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64) : 0x2::object::ID {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1))
    }

    public fun get_position_amounts(arg0: &FlowXExecutorConfig, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::bag::borrow<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&arg0.position_nfts, arg1);
        (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_x(v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::coins_owed_y(v0))
    }

    fun get_position_id<T0, T1>(arg0: &FlowXExecutorConfig, arg1: 0x2::object::ID, arg2: u64, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::object::ID>, PositionKey) {
        let v0 = PositionKey{
            token_a    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            token_b    : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            fee_rate   : arg2,
            tick_lower : arg3,
            tick_upper : arg4,
            owner      : arg1,
        };
        let v1 = if (!0x2::table::contains<PositionKey, 0x2::object::ID>(&arg0.position_key_ids, v0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PositionKey, 0x2::object::ID>(&arg0.position_key_ids, v0))
        };
        (v1, v0)
    }

    public fun get_position_liquidity(arg0: &FlowXExecutorConfig, arg1: 0x2::object::ID) : u128 {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&arg0.position_nfts, arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = FlowXExecutorConfig{
            id               : 0x2::object::new(arg0),
            version          : 1,
            operators        : 0x2::vec_map::empty<address, bool>(),
            position_key_ids : 0x2::table::new<PositionKey, 0x2::object::ID>(arg0),
            position_id_keys : 0x2::table::new<0x2::object::ID, PositionKey>(arg0),
            position_nfts    : 0x2::bag::new(arg0),
            access_cap       : 0x1::option::none<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(),
            pool_ids         : 0x2::vec_map::empty<0x2::object::ID, bool>(),
            allow_all_pools  : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FlowXExecutorConfig>(v1);
    }

    fun internal_collect_fee<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: 0x2::object::ID, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: 0x2::object::ID, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T0, T1>(arg0, arg4, 18446744073709551615, 18446744073709551615, arg2, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = CollectFeeEvent<T0, T1>{
            vault_id       : arg3,
            pool_id        : arg1,
            lp_id          : arg5,
            amount_token_a : 0x2::coin::value<T0>(&v3),
            amount_token_b : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<CollectFeeEvent<T0, T1>>(v4);
        (v3, v2)
    }

    fun internal_collect_reward<T0, T1, T2>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: 0x2::object::ID, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: 0x2::object::ID, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect_pool_reward<T0, T1, T2>(arg0, arg4, 18446744073709551615, arg2, arg6, arg7);
        let v1 = CollectRewardEvent<T0, T1>{
            vault_id            : arg3,
            pool_id             : arg1,
            lp_id               : arg5,
            reward_token_type   : 0x1::type_name::get<T2>(),
            reward_token_amount : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<CollectRewardEvent<T0, T1>>(v1);
        v0
    }

    fun internal_swap<T0, T1, T2, T3>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T3>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T3>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T2, T3>(arg1, arg9, true, arg7, arg8, arg2, arg10, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg9) {
            assert!(0x2::balance::value<T3>(&v5) > 0, 2);
            0x2::balance::value<T3>(&v5)
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
            0x2::balance::value<T2>(&v6)
        };
        let (v8, v9) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        let v10 = if (arg9) {
            assert!(0x2::coin::value<T2>(arg5) >= v8, 9);
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v8, arg11))
        } else {
            0x2::balance::zero<T2>()
        };
        let v11 = if (arg9) {
            0x2::balance::zero<T3>()
        } else {
            assert!(0x2::coin::value<T3>(arg6) >= v9, 9);
            0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg6, v9, arg11))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T2, T3>(arg1, v4, v10, v11, arg2, arg11);
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        0x2::coin::join<T3>(arg6, 0x2::coin::from_balance<T3>(v5, arg11));
        let v12 = 0x2::coin::value<T2>(arg5);
        if (v12 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v12, arg11), v0);
        };
        let v13 = 0x2::coin::value<T3>(arg6);
        if (v13 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, 0x2::coin::split<T3>(arg6, v13, arg11), v0);
        };
        let v14 = SwapEvent<T2, T3>{
            vault_id      : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(arg1),
            direction     : arg9,
            input_amount  : arg7,
            output_amount : v7,
        };
        0x2::event::emit<SwapEvent<T2, T3>>(v14);
    }

    fun internal_swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T2>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T2>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T2>(arg1, arg9, true, arg7, arg8, arg2, arg10, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T2>(&v5) > 0, 2);
            0x2::balance::value<T2>(&v5);
        } else {
            assert!(0x2::balance::value<T0>(&v6) > 0, 2);
            0x2::balance::value<T0>(&v6);
        };
        let (v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        let v9 = if (arg9) {
            assert!(0x2::coin::value<T0>(arg5) >= v7, 9);
            0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, v7, arg11))
        } else {
            0x2::balance::zero<T0>()
        };
        let v10 = if (arg9) {
            0x2::balance::zero<T2>()
        } else {
            assert!(0x2::coin::value<T2>(arg6) >= v8, 9);
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg6, v8, arg11))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T2>(arg1, v4, v9, v10, arg2, arg11);
        0x2::coin::join<T2>(arg6, 0x2::coin::from_balance<T2>(v5, arg11));
        0x2::coin::join<T0>(arg5, 0x2::coin::from_balance<T0>(v6, arg11));
        let v11 = 0x2::coin::value<T0>(arg5);
        if (v11 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg5, v11, arg11), arg11);
        };
        let v12 = 0x2::coin::value<T2>(arg6);
        if (v12 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg6, v12, arg11), v0);
        };
    }

    fun internal_swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T0>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T2, T0>(arg1, arg9, true, arg7, arg8, arg2, arg10, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg9) {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
            0x2::balance::value<T0>(&v5)
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
            0x2::balance::value<T2>(&v6)
        };
        let (v8, v9) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        let v10 = if (arg9) {
            assert!(0x2::coin::value<T2>(arg5) >= v8, 9);
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v8, arg11))
        } else {
            0x2::balance::zero<T2>()
        };
        let v11 = if (arg9) {
            0x2::balance::zero<T0>()
        } else {
            assert!(0x2::coin::value<T0>(arg6) >= v9, 9);
            0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, v9, arg11))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T2, T0>(arg1, v4, v10, v11, arg2, arg11);
        0x2::coin::join<T0>(arg6, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        let v12 = 0x2::coin::value<T2>(arg5);
        if (v12 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v12, arg11), v0);
        };
        let v13 = 0x2::coin::value<T0>(arg6);
        if (v13 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg6, v13, arg11), arg11);
        };
        let v14 = SwapEvent<T2, T0>{
            vault_id      : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T0>(arg1),
            direction     : arg9,
            input_amount  : arg7,
            output_amount : v7,
        };
        0x2::event::emit<SwapEvent<T2, T0>>(v14);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun pool_exists(arg0: &FlowXExecutorConfig, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.pool_ids, &arg1)
    }

    public entry fun remove_liquidity<T0, T1, T2, T3>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: u128, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T3>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T3>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let v4 = if (arg8) {
            assert!(arg7 == 0, 8);
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(v3)
        } else {
            assert!(arg7 > 0, 3);
            arg7
        };
        if (v4 == 0) {
            return
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::decrease_liquidity<T2, T3>(arg1, v3, v4, arg9, arg10, 0x2::clock::timestamp_ms(arg11) + 5000, arg2, arg11, arg12);
        let (v5, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T2, T3>(arg1, v3, 18446744073709551615, 18446744073709551615, arg2, arg11, arg12);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::coin::value<T2>(&v8);
        let v10 = 0x2::coin::value<T3>(&v7);
        if (v9 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v8, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v8);
        };
        if (v10 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v7, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v7);
        };
        emit_event_remove_liquidity<T2, T3>(v1, v3, v2, arg6, v9, v10);
    }

    public entry fun remove_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: u128, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T2>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T2>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let v4 = if (arg8) {
            assert!(arg7 == 0, 8);
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(v3)
        } else {
            assert!(arg7 > 0, 3);
            arg7
        };
        if (v4 == 0) {
            return
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::decrease_liquidity<T0, T2>(arg1, v3, v4, arg9, arg10, 0x2::clock::timestamp_ms(arg11) + 5000, arg2, arg11, arg12);
        let (v5, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T0, T2>(arg1, v3, 18446744073709551615, 18446744073709551615, arg2, arg11, arg12);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::coin::value<T0>(&v8);
        let v10 = 0x2::coin::value<T2>(&v7);
        if (v9 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v8, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(v8);
        };
        if (v10 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v7, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        emit_event_remove_liquidity<T0, T2>(v1, v3, v2, arg6, v9, v10);
    }

    public entry fun remove_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: 0x2::object::ID, arg7: u128, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T2, T0>(arg1, arg5));
        assert_pool_exists(arg0, v1);
        let v2 = 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3);
        assert!(v2 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg6).owner, 4);
        let v3 = 0x2::bag::borrow_mut<0x2::object::ID, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(&mut arg0.position_nfts, arg6);
        let v4 = if (arg8) {
            assert!(arg7 == 0, 8);
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(v3)
        } else {
            assert!(arg7 > 0, 3);
            arg7
        };
        if (v4 == 0) {
            return
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::decrease_liquidity<T2, T0>(arg1, v3, v4, arg9, arg10, 0x2::clock::timestamp_ms(arg11) + 5000, arg2, arg11, arg12);
        let (v5, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T2, T0>(arg1, v3, 18446744073709551615, 18446744073709551615, arg2, arg11, arg12);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::coin::value<T2>(&v8);
        let v10 = 0x2::coin::value<T0>(&v7);
        if (v9 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v8, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v8);
        };
        if (v10 > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v7, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(v7);
        };
        emit_event_remove_liquidity<T2, T0>(v1, v3, v2, arg6, v9, v10);
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.operators, &arg2);
        let v2 = RemoveOperatorEvent{operator: arg2};
        0x2::event::emit<RemoveOperatorEvent>(v2);
    }

    public entry fun remove_pool_id(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg1.pool_ids, &arg2);
        let v2 = RemovePoolEvent{pool_id: arg2};
        0x2::event::emit<RemovePoolEvent>(v2);
    }

    public entry fun remove_pool_ids(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &v1)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg1.pool_ids, &v1);
                let v4 = RemovePoolEvent{pool_id: v1};
                0x2::event::emit<RemovePoolEvent>(v4);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_allow_all_pools(arg0: &AdminCap, arg1: &mut FlowXExecutorConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.allow_all_pools = arg2;
    }

    public entry fun swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert!(arg6 > 0, 1);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T2>(arg1, arg5);
        assert_pool_exists(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T0, T2>(v0));
        let v1 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v2 = if (arg8) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg6, v1, arg10)
        } else {
            0x2::coin::zero<T0>(arg10)
        };
        let v3 = v2;
        let v4 = if (arg8) {
            0x2::coin::zero<T2>(arg10)
        } else {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg6, v1, arg10)
        };
        let v5 = v4;
        let v6 = &mut v3;
        let v7 = &mut v5;
        internal_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, v0, arg2, arg3, arg4, v6, v7, arg6, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v3, arg10);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T2>(&v5) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v5, v1);
        } else {
            0x2::coin::destroy_zero<T2>(v5);
        };
    }

    public entry fun swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &FlowXExecutorConfig, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert!(arg6 > 0, 1);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T2, T0>(arg1, arg5);
        assert_pool_exists(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pool_id<T2, T0>(v0));
        let v1 = 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(&arg0.access_cap);
        let v2 = if (arg8) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg6, v1, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let v3 = v2;
        let v4 = if (arg8) {
            0x2::coin::zero<T0>(arg10)
        } else {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg6, v1, arg10)
        };
        let v5 = v4;
        let v6 = &mut v3;
        let v7 = &mut v5;
        internal_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, v0, arg2, arg3, arg4, v6, v7, arg6, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<T2>(&v3) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v3, v1);
        } else {
            0x2::coin::destroy_zero<T2>(v3);
        };
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::add_fund<T0, T1>(arg3, v5, arg10);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{new_owner: arg1};
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

