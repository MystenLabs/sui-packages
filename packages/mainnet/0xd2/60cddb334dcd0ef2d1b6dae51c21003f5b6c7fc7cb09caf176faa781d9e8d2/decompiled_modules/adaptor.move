module 0xd260cddb334dcd0ef2d1b6dae51c21003f5b6c7fc7cb09caf176faa781d9e8d2::adaptor {
    struct CetusAdaptor has drop {
        dummy_field: bool,
    }

    struct CetusSwapped has copy, drop {
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct PositionStored has copy, drop {
        wallet_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct PositionClosed has copy, drop {
        wallet_id: 0x2::object::ID,
    }

    public fun add_liquidity_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = take_position(arg0, clone_string(&arg3));
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, v1, arg4, arg5, arg6, arg7, arg8, arg9);
        put_position(arg0, v0, arg3);
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = pull_from_vault<T0>(arg0, arg4, arg9);
        let v1 = pull_from_vault<T1>(arg0, arg5, arg9);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v4);
        assert!(v5 <= 0x2::balance::value<T0>(&v2), 1);
        assert!(v6 <= 0x2::balance::value<T1>(&v3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, v5), 0x2::balance::split<T1>(&mut v3, v6), v4);
        let v7 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T0>(arg0, v2, v7, arg9);
        let v8 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T1>(arg0, v3, v8, arg9);
    }

    fun assert_operator(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0)) {
            return
        };
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::is_service_authorized<CetusAdaptor>(arg0, v0), 2);
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::string::as_bytes(arg0))
    }

    public fun close_empty_position<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg4);
        let v0 = take_position(arg0, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v0);
        let v1 = PositionClosed{wallet_id: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0)};
        0x2::event::emit<PositionClosed>(v1);
    }

    public fun collect_fees_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg5);
        let v0 = take_position(arg0, clone_string(&arg3));
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v0, arg4);
        let v3 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T0>(arg0, v1, v3, arg5);
        let v4 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T1>(arg0, v2, v4, arg5);
        put_position(arg0, v0, arg3);
    }

    public fun collect_reward_to_vault<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: 0x1::string::String, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg7);
        let v0 = take_position(arg0, clone_string(&arg4));
        let v1 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v0, arg3, arg5, arg6), v1, arg7);
        put_position(arg0, v0, arg4);
    }

    fun credit_or_destroy_balance<T0: drop, T1>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x2::balance::Balance<T1>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
        } else {
            0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), arg2);
        };
    }

    public fun open_position_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg11);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg11);
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, v1, arg6, arg7, arg8, arg9, arg10, arg11);
        put_position(arg0, v0, arg3);
        let v2 = PositionStored{
            wallet_id   : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
        };
        0x2::event::emit<PositionStored>(v2);
    }

    fun pull_from_vault<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0);
        let v1 = CetusAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<CetusAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<CetusAdaptor, T0>(v1, arg1, v0), arg2);
        let v4 = CetusAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<CetusAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<CetusAdaptor, T0>(v4, arg1, v0));
        v2
    }

    fun put_position(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0x1::string::String) {
        let v0 = CetusAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_asset_from_service<CetusAdaptor, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, arg2, v0);
    }

    public fun remove_liquidity_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: u128, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 3);
        assert_operator(arg0, arg8);
        let v0 = take_position(arg0, clone_string(&arg3));
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, T1>(arg1, arg2, &mut v0, arg4, arg5, arg6, arg7);
        let v3 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T0>(arg0, v1, v3, arg8);
        let v4 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T1>(arg0, v2, v4, arg8);
        put_position(arg0, v0, arg3);
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = CetusAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<CetusAdaptor, T0, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<CetusAdaptor, T0, T1>(v0, arg3, arg4), arg7);
        let v3 = 0x2::coin::into_balance<T0>(v1);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg3, arg5, arg6);
        let v7 = v6;
        0x2::balance::join<T0>(&mut v3, v4);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        assert!(v8 <= 0x2::balance::value<T0>(&v3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v3, v8), 0x2::balance::zero<T1>(), v7);
        let v9 = 0x2::coin::from_balance<T1>(v5, arg7);
        let v10 = 0x2::coin::value<T1>(&v9);
        let v11 = CetusAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<CetusAdaptor, T0, T1>(arg0, v2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<CetusAdaptor, T0, T1>(v11, arg3, v10), v9);
        let v12 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T0>(arg0, v3, v12, arg7);
        let v13 = CetusSwapped{
            a2b        : true,
            amount_in  : arg3,
            amount_out : v10,
        };
        0x2::event::emit<CetusSwapped>(v13);
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = CetusAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<CetusAdaptor, T1, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<CetusAdaptor, T1, T0>(v0, arg3, arg4), arg7);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg3, arg5, arg6);
        let v7 = v6;
        0x2::balance::join<T1>(&mut v3, v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        assert!(v8 <= 0x2::balance::value<T1>(&v3), 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, v8), v7);
        let v9 = 0x2::coin::from_balance<T0>(v4, arg7);
        let v10 = 0x2::coin::value<T0>(&v9);
        let v11 = CetusAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<CetusAdaptor, T1, T0>(arg0, v2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<CetusAdaptor, T1, T0>(v11, arg3, v10), v9);
        let v12 = CetusAdaptor{dummy_field: false};
        credit_or_destroy_balance<CetusAdaptor, T1>(arg0, v3, v12, arg7);
        let v13 = CetusSwapped{
            a2b        : false,
            amount_in  : arg3,
            amount_out : v10,
        };
        0x2::event::emit<CetusSwapped>(v13);
    }

    fun take_position(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x1::string::String) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = CetusAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::take_asset_for_service<CetusAdaptor, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v7
}

