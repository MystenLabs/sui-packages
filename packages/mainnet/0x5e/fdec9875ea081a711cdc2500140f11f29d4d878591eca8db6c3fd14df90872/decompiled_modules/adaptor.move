module 0x5efdec9875ea081a711cdc2500140f11f29d4d878591eca8db6c3fd14df90872::adaptor {
    struct MagmaAdaptor has drop {
        dummy_field: bool,
    }

    struct PositionStored has copy, drop {
        wallet_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct PositionClosed has copy, drop {
        wallet_id: 0x2::object::ID,
    }

    public fun add_liquidity_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = take_position(arg0, clone_string(&arg3));
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, v1, arg4, arg5, arg6, arg7, arg8, arg9);
        put_position(arg0, v0, arg3);
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = pull_from_vault<T0>(arg0, arg4, arg9);
        let v1 = pull_from_vault<T1>(arg0, arg5, arg9);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, arg3, arg6, arg7, arg8, arg9);
        let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v4);
        assert!(v5 <= 0x2::balance::value<T0>(&v2), 1);
        assert!(v6 <= 0x2::balance::value<T1>(&v3), 1);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, v5), 0x2::balance::split<T1>(&mut v3, v6), v4);
        credit_or_destroy_balance<T0>(arg0, v2, arg9);
        credit_or_destroy_balance<T1>(arg0, v3, arg9);
    }

    fun assert_operator(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0)) {
            return
        };
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::is_service_authorized<MagmaAdaptor>(arg0, v0), 0);
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::string::as_bytes(arg0))
    }

    public fun close_empty_position<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg4);
        let v0 = take_position(arg0, arg3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg1, arg2, v0);
        let v1 = PositionClosed{wallet_id: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0)};
        0x2::event::emit<PositionClosed>(v1);
    }

    public fun collect_fees_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg5);
        let v0 = take_position(arg0, clone_string(&arg3));
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg2, &v0, arg4);
        credit_or_destroy_balance<T0>(arg0, v1, arg5);
        credit_or_destroy_balance<T1>(arg0, v2, arg5);
        put_position(arg0, v0, arg3);
    }

    public fun collect_reward_to_vault<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg4: 0x1::string::String, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg7);
        let v0 = take_position(arg0, clone_string(&arg4));
        credit_or_destroy_balance<T2>(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v0, arg3, arg5, arg6), arg7);
        put_position(arg0, v0, arg4);
    }

    fun credit_or_destroy_balance<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            let v0 = MagmaAdaptor{dummy_field: false};
            0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<MagmaAdaptor, T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), v0);
        };
    }

    public fun open_position_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg11);
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg11);
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, v1, arg6, arg7, arg8, arg9, arg10, arg11);
        put_position(arg0, v0, arg3);
        let v2 = PositionStored{
            wallet_id   : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v0),
        };
        0x2::event::emit<PositionStored>(v2);
    }

    fun pull_from_vault<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0);
        let v1 = MagmaAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<MagmaAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<MagmaAdaptor, T0>(v1, arg1, v0), arg2);
        let v4 = MagmaAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<MagmaAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<MagmaAdaptor, T0>(v4, arg1, v0));
        v2
    }

    fun put_position(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg2: 0x1::string::String) {
        let v0 = MagmaAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_asset_from_service<MagmaAdaptor, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, arg1, arg2, v0);
    }

    public fun remove_liquidity_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x1::string::String, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 2);
        assert_operator(arg0, arg6);
        let v0 = take_position(arg0, clone_string(&arg3));
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v0, arg4, arg5);
        credit_or_destroy_balance<T0>(arg0, v1, arg6);
        credit_or_destroy_balance<T1>(arg0, v2, arg6);
        put_position(arg0, v0, arg3);
    }

    fun take_position(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x1::string::String) : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position {
        let v0 = MagmaAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::take_asset_for_service<MagmaAdaptor, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v7
}

