module 0xe7e94107263f4a91642b92a3e78fcccd405b31fcba28939448031309e01ccb48::mmt_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionKey has copy, drop, store {
        pool: 0x2::object::ID,
        owner: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct MmtExecutorConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        operators: 0x2::vec_map::VecMap<address, bool>,
        position_key_ids: 0x2::table::Table<PositionKey, 0x2::object::ID>,
        position_id_keys: 0x2::table::Table<0x2::object::ID, PositionKey>,
        position_nfts: 0x2::bag::Bag,
        access_cap: 0x1::option::Option<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>,
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

    public entry fun swap<T0, T1, T2, T3>(arg0: &MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T3>(arg9)
        } else {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T3>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        internal_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T3>(&v4) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v4);
        };
    }

    public entry fun add_liquidity<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u32, arg4: u32, arg5: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg6: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert!(arg7 > 0 || arg8 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg12);
        let v1 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T2, T3>(arg1, 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, v0), 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, arg7, v1, arg12), 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T3>(arg6, arg5, arg8, v1, arg12), arg9, arg10, arg11, arg2, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = arg7;
        let v7 = arg8;
        if (0x2::coin::value<T2>(&v5) > 0) {
            v6 = arg7 - 0x2::coin::value<T2>(&v5);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg6, arg5, v5, v1);
        } else {
            0x2::coin::destroy_zero<T2>(v5);
        };
        if (0x2::coin::value<T3>(&v4) > 0) {
            v7 = arg8 - 0x2::coin::value<T3>(&v4);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T3>(arg6, arg5, v4, v1);
        } else {
            0x2::coin::destroy_zero<T3>(v4);
        };
        emit_event_add_liquidity<T2, T3>(arg0, arg1, 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg5), v0, v6, v7, arg3, arg4);
    }

    public entry fun close_position<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1);
        let v3 = 0x2::table::remove<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, arg5);
        assert!(v1 == v3.owner, 4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(0x2::bag::remove<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5), arg2, arg7);
        0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::withdraw_lp<T0, T1>(arg4, arg3, v2, v0);
        let v4 = ClosePositionEvent<T2, T3>{
            vault_id   : v1,
            pool_id    : v2,
            lp_id      : arg5,
            tick_lower : v3.tick_lower,
            tick_upper : v3.tick_upper,
        };
        0x2::event::emit<ClosePositionEvent<T2, T3>>(v4);
        0x2::table::remove<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v3);
    }

    public entry fun open_position<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: u32, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, true, arg7);
    }

    public entry fun remove_liquidity<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert!(arg6 > 0 || arg7, 3);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let v3 = arg6;
        if (arg7) {
            v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v2);
        };
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T2, T3>(arg1, v2, v3, arg8, arg9, arg10, arg2, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::coin::value<T2>(&v7);
        let v9 = 0x2::coin::value<T3>(&v6);
        if (v8 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v7, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        if (v9 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v6, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v6);
        };
        emit_event_remove_liquidity<T2, T3>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1), v2, v1, arg5, v8, v9);
    }

    public entry fun add_access_cap(arg0: &AdminCap, arg1: &mut MmtExecutorConfig, arg2: 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public entry fun add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u32, arg4: u32, arg5: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg6: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert!(arg7 > 0 || arg8 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg12);
        let v1 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T2>(arg1, 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, v0), 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_vault_funds<T0, T1>(arg6, arg5, arg7, v1, arg12), 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, arg8, v1, arg12), arg9, arg10, arg11, arg2, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = arg7;
        let v7 = arg8;
        if (0x2::coin::value<T0>(&v5) > 0) {
            v6 = arg7 - 0x2::coin::value<T0>(&v5);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg5, v5, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T2>(&v4) > 0) {
            v7 = arg8 - 0x2::coin::value<T2>(&v4);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg6, arg5, v4, v1);
        } else {
            0x2::coin::destroy_zero<T2>(v4);
        };
        emit_event_add_liquidity<T0, T2>(arg0, arg1, 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg5), v0, v6, v7, arg3, arg4);
    }

    public entry fun add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u32, arg4: u32, arg5: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg6: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert!(arg7 > 0 || arg8 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T2, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg12);
        let v1 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T2, T0>(arg1, 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, v0), 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, arg7, v1, arg12), 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_vault_funds<T0, T1>(arg6, arg5, arg8, v1, arg12), arg9, arg10, arg11, arg2, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = arg7;
        let v7 = arg8;
        if (0x2::coin::value<T2>(&v5) > 0) {
            v6 = arg7 - 0x2::coin::value<T2>(&v5);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg6, arg5, v5, v1);
        } else {
            0x2::coin::destroy_zero<T2>(v5);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            v7 = arg8 - 0x2::coin::value<T0>(&v4);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg5, v4, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        emit_event_add_liquidity<T2, T0>(arg0, arg1, 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg5), v0, v6, v7, arg3, arg4);
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut MmtExecutorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 5);
        0x2::vec_map::insert<address, bool>(&mut arg1.operators, arg2, true);
        let v0 = AddOperatorEvent{operator: arg2};
        0x2::event::emit<AddOperatorEvent>(v0);
    }

    public fun assert_is_operator(arg0: &MmtExecutorConfig, arg1: address) {
        assert!(0x2::vec_map::contains<address, bool>(&arg0.operators, &arg1), 4);
    }

    public fun assert_version(arg0: &MmtExecutorConfig) {
        assert!(arg0.version == 1, 7);
    }

    public entry fun collect_fee<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let (v3, v4) = internal_collect_fee<T2, T3>(arg1, arg2, v1, v2, arg5, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        if (0x2::coin::value<T2>(&v6) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v6, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v6);
        };
        if (0x2::coin::value<T3>(&v5) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v5, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v5);
        };
    }

    public entry fun collect_fee_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let (v3, v4) = internal_collect_fee<T0, T2>(arg1, arg2, v1, v2, arg5, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        if (0x2::coin::value<T0>(&v6) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v6, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<T2>(&v5) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v5, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v5);
        };
    }

    public entry fun collect_fee_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let (v3, v4) = internal_collect_fee<T2, T0>(arg1, arg2, v1, v2, arg5, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        if (0x2::coin::value<T2>(&v6) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v6, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v6);
        };
        if (0x2::coin::value<T0>(&v5) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v5, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
    }

    public entry fun collect_reward<T0, T1, T2, T3, T4>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let v3 = internal_collect_reward<T2, T3, T4>(arg1, arg2, v1, v2, arg5, arg6, arg7);
        if (0x2::coin::value<T4>(&v3) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T4>(arg4, arg3, v3, v0);
        } else {
            0x2::coin::destroy_zero<T4>(v3);
        };
    }

    public entry fun collect_reward_have_reward_in_vault<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg7));
        assert_version(arg0);
        let v0 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v0 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v1 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let v2 = internal_collect_reward<T2, T3, T0>(arg1, arg2, v0, v1, arg5, arg6, arg7);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v2, arg7);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
    }

    fun emit_event_add_liquidity<T0, T1>(arg0: &MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u32, arg7: u32) {
        let (v0, v1) = get_position_amounts(arg0, arg3);
        let v2 = AddLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T1>(arg1),
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

    fun emit_event_remove_liquidity<T0, T1>(arg0: 0x2::object::ID, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = RemoveLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : arg0,
            lp_id                         : arg3,
            amount_token_a                : arg4,
            amount_token_b                : arg5,
            after_position_liquidity      : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg1),
            after_position_amount_token_a : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::owed_coin_x(arg1),
            after_position_amount_token_b : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::owed_coin_y(arg1),
        };
        0x2::event::emit<RemoveLiquidityEvent<T0, T1>>(v0);
    }

    fun get_or_create_position<T0, T1, T2, T3>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u32, arg4: u32, arg5: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg6: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2) = get_position_id<T0, T1, T2, T3>(arg0, arg1, arg5, arg3, arg4, arg8);
        let v3 = v1;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            if (arg7) {
                let v6 = OpenPositionEvent<T2, T3>{
                    vault_id   : 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg5),
                    pool_id    : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1),
                    lp_id      : v5,
                    tick_lower : arg3,
                    tick_upper : arg4,
                };
                0x2::event::emit<OpenPositionEvent<T2, T3>>(v6);
            };
            v5
        } else {
            let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T2, T3>(arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4), arg2, arg8);
            let v8 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v7);
            let v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1);
            0x2::bag::add<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, v8, v7);
            0x2::table::add<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v2, v8);
            0x2::table::add<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, v8, v2);
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_lp<T0, T1>(arg6, arg5, v9, v8, v0);
            let v10 = OpenPositionEvent<T2, T3>{
                vault_id   : 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg5),
                pool_id    : v9,
                lp_id      : v8,
                tick_lower : arg3,
                tick_upper : arg4,
            };
            0x2::event::emit<OpenPositionEvent<T2, T3>>(v10);
            v8
        }
    }

    public fun get_position_amounts(arg0: &MmtExecutorConfig, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::bag::borrow<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nfts, arg1);
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::owed_coin_x(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::owed_coin_y(v0))
    }

    fun get_position_id<T0, T1, T2, T3>(arg0: &MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::object::ID>, PositionKey) {
        let v0 = PositionKey{
            pool       : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1),
            owner      : 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg2),
            tick_lower : arg3,
            tick_upper : arg4,
        };
        let v1 = if (!0x2::table::contains<PositionKey, 0x2::object::ID>(&arg0.position_key_ids, v0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PositionKey, 0x2::object::ID>(&arg0.position_key_ids, v0))
        };
        (v1, v0)
    }

    public fun get_position_liquidity(arg0: &MmtExecutorConfig, arg1: 0x2::object::ID) : u128 {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg0.position_nfts, arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = MmtExecutorConfig{
            id               : 0x2::object::new(arg0),
            version          : 1,
            operators        : 0x2::vec_map::empty<address, bool>(),
            position_key_ids : 0x2::table::new<PositionKey, 0x2::object::ID>(arg0),
            position_id_keys : 0x2::table::new<0x2::object::ID, PositionKey>(arg0),
            position_nfts    : 0x2::bag::new(arg0),
            access_cap       : 0x1::option::none<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<MmtExecutorConfig>(v1);
    }

    fun internal_collect_fee<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::object::ID, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg0, arg3, arg5, arg1, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = CollectFeeEvent<T0, T1>{
            vault_id       : arg2,
            pool_id        : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T1>(arg0),
            lp_id          : arg4,
            amount_token_a : 0x2::coin::value<T0>(&v3),
            amount_token_b : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<CollectFeeEvent<T0, T1>>(v4);
        (v3, v2)
    }

    fun internal_collect_reward<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::object::ID, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg0, arg3, arg5, arg1, arg6);
        let v1 = CollectRewardEvent<T0, T1>{
            vault_id            : arg2,
            pool_id             : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T1>(arg0),
            lp_id               : arg4,
            reward_token_type   : 0x1::type_name::get<T2>(),
            reward_token_amount : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<CollectRewardEvent<T0, T1>>(v1);
        v0
    }

    fun internal_swap<T0, T1, T2, T3>(arg0: &MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T3>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T3>(arg1, arg9, true, arg7, arg8, arg10, arg2, arg11);
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
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v10 = if (arg9) {
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v8, arg11))
        } else {
            0x2::balance::zero<T2>()
        };
        let v11 = if (arg9) {
            0x2::balance::zero<T3>()
        } else {
            0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg6, v9, arg11))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T3>(arg1, v4, v10, v11, arg2, arg11);
        0x2::coin::join<T3>(arg6, 0x2::coin::from_balance<T3>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        let v12 = 0x2::coin::value<T2>(arg5);
        if (v12 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v12, arg11), v0);
        };
        let v13 = 0x2::coin::value<T3>(arg6);
        if (v13 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, 0x2::coin::split<T3>(arg6, v13, arg11), v0);
        };
        let v14 = SwapEvent<T2, T3>{
            vault_id      : 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1),
            direction     : arg9,
            input_amount  : arg7,
            output_amount : v7,
        };
        0x2::event::emit<SwapEvent<T2, T3>>(v14);
    }

    fun internal_swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T2>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T2>(arg1, arg9, true, arg7, arg8, arg10, arg2, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg9) {
            assert!(0x2::balance::value<T2>(&v5) > 0, 2);
            0x2::balance::value<T2>(&v5)
        } else {
            assert!(0x2::balance::value<T0>(&v6) > 0, 2);
            0x2::balance::value<T0>(&v6)
        };
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v10 = if (arg9) {
            0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, v8, arg11))
        } else {
            0x2::balance::zero<T0>()
        };
        let v11 = if (arg9) {
            0x2::balance::zero<T2>()
        } else {
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg6, v9, arg11))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T2>(arg1, v4, v10, v11, arg2, arg11);
        0x2::coin::join<T2>(arg6, 0x2::coin::from_balance<T2>(v5, arg11));
        0x2::coin::join<T0>(arg5, 0x2::coin::from_balance<T0>(v6, arg11));
        let v12 = 0x2::coin::value<T0>(arg5);
        if (v12 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg5, v12, arg11), arg11);
        };
        let v13 = 0x2::coin::value<T2>(arg6);
        if (v13 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg6, v13, arg11), v0);
        };
        let v14 = SwapEvent<T0, T2>{
            vault_id      : 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1),
            direction     : arg9,
            input_amount  : arg7,
            output_amount : v7,
        };
        0x2::event::emit<SwapEvent<T0, T2>>(v14);
    }

    fun internal_swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T0>(arg1, arg9, true, arg7, arg8, arg10, arg2, arg11);
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
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v10 = if (arg9) {
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v8, arg11))
        } else {
            0x2::balance::zero<T2>()
        };
        let v11 = if (arg9) {
            0x2::balance::zero<T0>()
        } else {
            0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, v9, arg11))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T0>(arg1, v4, v10, v11, arg2, arg11);
        0x2::coin::join<T0>(arg6, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        let v12 = 0x2::coin::value<T2>(arg5);
        if (v12 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v12, arg11), v0);
        };
        let v13 = 0x2::coin::value<T0>(arg6);
        if (v13 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg6, v13, arg11), arg11);
        };
        let v14 = SwapEvent<T2, T0>{
            vault_id      : 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1),
            direction     : arg9,
            input_amount  : arg7,
            output_amount : v7,
        };
        0x2::event::emit<SwapEvent<T2, T0>>(v14);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut MmtExecutorConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public entry fun remove_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert!(arg6 > 0 || arg7, 3);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let v3 = arg6;
        if (arg7) {
            v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v2);
        };
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T2>(arg1, v2, v3, arg8, arg9, arg10, arg2, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::coin::value<T0>(&v7);
        let v9 = 0x2::coin::value<T2>(&v6);
        if (v8 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v7, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v7);
        };
        if (v9 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v6, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v6);
        };
        emit_event_remove_liquidity<T0, T2>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T2>(arg1), v2, v1, arg5, v8, v9);
    }

    public entry fun remove_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert!(arg6 > 0 || arg7, 3);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = 0x2::object::id<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>>(arg3);
        assert!(v1 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg5).owner, 4);
        let v2 = 0x2::bag::borrow_mut<0x2::object::ID, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.position_nfts, arg5);
        let v3 = arg6;
        if (arg7) {
            v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v2);
        };
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T2, T0>(arg1, v2, v3, arg8, arg9, arg10, arg2, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::coin::value<T2>(&v7);
        let v9 = 0x2::coin::value<T0>(&v6);
        if (v8 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v7, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        if (v9 > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v6, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        emit_event_remove_liquidity<T2, T0>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T0>(arg1), v2, v1, arg5, v8, v9);
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut MmtExecutorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.operators, &arg2);
        let v2 = RemoveOperatorEvent{operator: arg2};
        0x2::event::emit<RemoveOperatorEvent>(v2);
    }

    public entry fun swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T2>(arg9)
        } else {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        internal_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v2, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (0x2::coin::value<T2>(&v4) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v4);
        };
    }

    public entry fun swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::Vault<T0, T1>, arg4: &mut 0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T0>(arg9)
        } else {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        internal_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            0xd5972baf79af5cd5077442621defc9b6c62e919a820958907a26a93d23163142::vault::add_fund<T0, T1>(arg3, v4, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{new_owner: arg1};
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

