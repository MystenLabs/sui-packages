module 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::lp {
    struct Strategy<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::Config, arg1: &Strategy<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::wallet::Vault<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::assert_operator(arg0, arg7);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 131);
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::wallet::destroy_or_deposit_balance<T2>(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), arg4, true, arg6));
    }

    public fun balances<T0, T1>(arg0: &Strategy<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public entry fun close<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::Config, arg1: &mut Strategy<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::assert_operator(arg0, arg4);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 131);
        let v0 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0) == 0, 132);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v0);
    }

    public fun create_strategy<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategy<T0, T1>{
            id        : 0x2::object::new(arg1),
            position  : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            balance_a : 0x2::balance::zero<T0>(),
            balance_b : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Strategy<T0, T1>>(v0);
    }

    public fun deposit_a<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Strategy<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance_a, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun deposit_b<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Strategy<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg1.balance_b, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun has_position<T0, T1>(arg0: &Strategy<T0, T1>) : bool {
        0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    public entry fun open<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::Config, arg1: &mut Strategy<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::assert_operator(arg0, arg9);
        assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 130);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg9);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v0, arg6, arg7, arg8);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut arg1.balance_a, v2), 0x2::balance::split<T1>(&mut arg1.balance_b, v3), v1);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position, v0);
    }

    public entry fun remove_all<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::Config, arg1: &mut Strategy<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::access::assert_operator(arg0, arg5);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 131);
        let v0 = 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.position);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0);
        if (v1 > 0) {
            let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v0, v1, arg4);
            0x2::balance::join<T0>(&mut arg1.balance_a, v2);
            0x2::balance::join<T1>(&mut arg1.balance_b, v3);
        };
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), false);
        0x2::balance::join<T0>(&mut arg1.balance_a, v4);
        0x2::balance::join<T1>(&mut arg1.balance_b, v5);
    }

    public fun withdraw_a<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Strategy<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::asserts::must_amount(arg2);
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::transfer_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_a, arg2), arg3, arg4);
    }

    public fun withdraw_b<T0, T1>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Strategy<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::asserts::must_amount(arg2);
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::transfer_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_b, arg2), arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

