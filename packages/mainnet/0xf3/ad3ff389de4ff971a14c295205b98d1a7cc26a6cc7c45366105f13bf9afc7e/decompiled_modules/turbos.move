module 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::turbos {
    struct PositionActivated has copy, drop {
        nft_address: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reused: bool,
        intent: address,
    }

    struct PositionSettled has copy, drop {
        nft_address: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun collect_fees<T0, T1, T2>(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg8);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check_intent<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg4);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::assert_removed<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
        if (0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::fees_collected<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3)) {
            return
        };
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg1, arg2, 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::borrow_current<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3), 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg8), arg5, arg6, arg7, arg8);
        send_pair<T0, T1>(v0, v1, 0x2::tx_context::sender(arg8));
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::mark_fees_collected<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg10);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check_intent<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg4);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::assert_removed<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()) != 0x1::ascii::string(b"5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS"), 11);
        0x2::coin::send_funds<T3>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg1, arg2, 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::borrow_current<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3), arg5, arg6, 18446744073709551615, 0x2::tx_context::sender(arg10), arg7, arg8, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun finish_settlement(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::pool_id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0), arg4);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check_intent<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
        let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::borrow_current<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg2)));
        assert!(v2 == 0, 10);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::finish<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg2);
        let v3 = PositionSettled{
            nft_address : arg2,
            pool_id     : 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::pool_id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0),
        };
        0x2::event::emit<PositionSettled>(v3);
    }

    public fun import_empty(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg2), arg4);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::assert_idle<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0);
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg2));
        assert!(v2 == 0, 10);
        let v3 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::key(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v1));
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::activate<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v3, 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::store<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v3, arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&arg2), true, arg3);
    }

    public fun open<T0, T1, T2>(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg17: &mut 0x2::tx_context::TxContext) {
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg17);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::assert_idle<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0);
        let v0 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::key(tick_bits(arg5, arg6), tick_bits(arg7, arg8));
        let v1 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::has_range<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v0);
        if (v1) {
            let v2 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::borrow_range<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v0, 0);
            let (_, _, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v2));
            assert!(v5 == 0, 10);
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, v2, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17);
            send_pair<T0, T1>(v6, v7, 0x2::tx_context::sender(arg17));
        } else {
            let (v8, v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17);
            send_pair<T0, T1>(v9, v10, 0x2::tx_context::sender(arg17));
            0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::store<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v0, v8);
        };
        let v11 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::borrow_range<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v0, 0);
        let v12 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(v11);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::activate<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v0, 0, v12, false, arg13);
        let v13 = PositionActivated{
            nft_address : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v11),
            position_id : v12,
            pool_id     : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1),
            reused      : v1,
            intent      : arg13,
        };
        0x2::event::emit<PositionActivated>(v13);
    }

    public fun remove<T0, T1, T2>(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg8);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::check_intent<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg4);
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::assert_active<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
        let v0 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::borrow_current<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
        let (_, _, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v0));
        let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg1, arg2, v0, v3, 0, 0, arg5, arg6, arg7, arg8);
        send_pair<T0, T1>(v4, v5, 0x2::tx_context::sender(arg8));
        let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg1, arg2, v0, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg8), arg5, arg6, arg7, arg8);
        send_pair<T0, T1>(v6, v7, 0x2::tx_context::sender(arg8));
        0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::mark_removed<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg3);
    }

    public fun remove_latest<T0, T1, T2>(arg0: &mut 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::Vault<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf3ad3ff389de4ff971a14c295205b98d1a7cc26a6cc7c45366105f13bf9afc7e::vault::latest<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0);
        remove<T0, T1, T2>(arg0, arg1, arg2, v0, arg3, arg4, arg5, arg6, arg7);
    }

    fun send_pair<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address) {
        0x2::coin::send_funds<T0>(arg0, arg2);
        0x2::coin::send_funds<T1>(arg1, arg2);
    }

    fun tick_bits(arg0: u32, arg1: bool) : u32 {
        if (arg1 && arg0 != 0) {
            4294967295 - arg0 + 1
        } else {
            arg0
        }
    }

    // decompiled from Move bytecode v7
}

