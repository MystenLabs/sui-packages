module 0x5033bb2f1002c872f19ab2a3ec144fa2a9b5be3cbd4d8c05b932623d55a4675::adaptor {
    struct TurbosAdaptor has drop {
        dummy_field: bool,
    }

    struct PositionStored has copy, drop {
        wallet_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct PositionClosed has copy, drop {
        wallet_id: 0x2::object::ID,
    }

    public fun add_liquidity_from_vault<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg11);
        let v0 = take_position(arg0, clone_string(&arg4));
        let v1 = pull_from_vault<T0>(arg0, arg5, arg11);
        let v2 = pull_from_vault<T1>(arg0, arg6, arg11);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, v1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v4, v2);
        let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg1, arg2, v3, v4, &mut v0, arg5, arg6, arg7, arg8, arg9, arg10, arg3, arg11);
        credit_or_destroy<T0>(arg0, v5);
        credit_or_destroy<T1>(arg0, v6);
        put_position(arg0, v0, arg4);
    }

    fun assert_operator(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0)) {
            return
        };
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::is_service_authorized<TurbosAdaptor>(arg0, v0), 0);
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::string::as_bytes(arg0))
    }

    public fun close_empty_position<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg4);
        let v0 = take_position(arg0, arg3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg1, v0, arg2, arg4);
        let v1 = PositionClosed{wallet_id: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0)};
        0x2::event::emit<PositionClosed>(v1);
    }

    public fun collect_fees_to_vault<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg9);
        let v0 = take_position(arg0, clone_string(&arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg1, arg2, &mut v0, arg5, arg6, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0), arg7, arg8, arg3, arg9);
        credit_or_destroy<T0>(arg0, v1);
        credit_or_destroy<T1>(arg0, v2);
        put_position(arg0, v0, arg4);
    }

    public fun collect_reward_to_vault<T0, T1, T2, T3>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg10);
        let v0 = take_position(arg0, clone_string(&arg5));
        credit_or_destroy<T3>(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg1, arg2, &mut v0, arg3, arg6, arg7, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0), arg8, arg9, arg4, arg10));
        put_position(arg0, v0, arg5);
    }

    fun credit_or_destroy<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            let v0 = TurbosAdaptor{dummy_field: false};
            0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<TurbosAdaptor, T0>(arg0, arg1, v0);
        };
    }

    public fun open_position_from_vault<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x1::string::String, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg15);
        let v0 = pull_from_vault<T0>(arg0, arg9, arg15);
        let v1 = pull_from_vault<T1>(arg0, arg10, arg15);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v3, v1);
        let (v4, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg1, arg2, v2, v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg3, arg15);
        let v7 = v4;
        credit_or_destroy<T0>(arg0, v5);
        credit_or_destroy<T1>(arg0, v6);
        put_position(arg0, v7, arg4);
        let v8 = PositionStored{
            wallet_id   : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            position_id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v7),
        };
        0x2::event::emit<PositionStored>(v8);
    }

    fun pull_from_vault<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0);
        let v1 = TurbosAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<TurbosAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<TurbosAdaptor, T0>(v1, arg1, v0), arg2);
        let v4 = TurbosAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<TurbosAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<TurbosAdaptor, T0>(v4, arg1, v0));
        v2
    }

    fun put_position(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg2: 0x1::string::String) {
        let v0 = TurbosAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_asset_from_service<TurbosAdaptor, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, arg2, v0);
    }

    public fun remove_liquidity_to_vault<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x1::string::String, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 1);
        assert_operator(arg0, arg10);
        let v0 = take_position(arg0, clone_string(&arg4));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg1, arg2, &mut v0, arg5, arg6, arg7, arg8, arg9, arg3, arg10);
        credit_or_destroy<T0>(arg0, v1);
        credit_or_destroy<T1>(arg0, v2);
        put_position(arg0, v0, arg4);
    }

    fun take_position(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x1::string::String) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        let v0 = TurbosAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::take_asset_for_service<TurbosAdaptor, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v7
}

