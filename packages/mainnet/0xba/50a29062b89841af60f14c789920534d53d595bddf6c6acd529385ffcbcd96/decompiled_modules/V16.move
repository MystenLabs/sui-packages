module 0xba50a29062b89841af60f14c789920534d53d595bddf6c6acd529385ffcbcd96::V16 {
    struct MEVEvent has copy, drop, store {
        amountOut: u64,
    }

    struct MEVStepEvent has copy, drop, store {
        coin_in: u64,
        coin_out: u64,
        coin_in_left: u64,
    }

    public fun cetus_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        0x2::balance::value<T1>(&v5);
        0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(v5, arg5));
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v1, arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg5)), 0x2::balance::zero<T1>(), v4);
        0x2::pay::keep<T0>(arg0, arg5);
        let v7 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T1>(&v6),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v7);
        v6
    }

    public fun cetus_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, arg3, arg4);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::value<T0>(&v6);
        0x2::coin::join<T1>(&mut arg0, 0x2::coin::from_balance<T1>(v3, arg5));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v6, arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg5)), v5);
        0x2::pay::keep<T1>(arg0, arg5);
        let v7 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T0>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v7);
        v1
    }

    public fun deepbook_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let (v2, v3) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, &v0, arg2, v1, false, arg0, 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4), arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v4),
            coin_in_left : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<MEVStepEvent>(v6);
        0x2::pay::keep<T0>(v5, arg4);
        0xdee9::custodian_v2::delete_account_cap(v0);
        v4
    }

    public fun deepbook_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T1, T0>(arg1, arg2, &v0, v1, arg3, arg0, arg4);
        let v5 = v3;
        let v6 = v2;
        let v7 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v6),
            coin_in_left : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<MEVStepEvent>(v7);
        0x2::pay::keep<T0>(v5, arg4);
        0xdee9::custodian_v2::delete_account_cap(v0);
        v6
    }

    public fun flow_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg0, arg2);
        let v1 = MEVStepEvent{
            coin_in      : 0x2::coin::value<T0>(&arg0),
            coin_out     : 0x2::coin::value<T1>(&v0),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun keep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (arg2) {
            if (v0 < arg1) {
                abort 222
            };
        };
        let v1 = MEVEvent{amountOut: v0};
        0x2::event::emit<MEVEvent>(v1);
        0x2::pay::keep<T0>(arg0, arg3);
    }

    public fun kriya_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg0, v0, arg2, arg3);
        let v2 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T1>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v2);
        v1
    }

    public fun kriya_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg0, v0, arg2, arg3);
        let v2 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T0>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v2);
        v1
    }

    public entry fun turbo_a_to_b<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, v0, 0x2::coin::value<T0>(&arg0), 0, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg5), arg2, arg4, arg3, arg5);
    }

    public entry fun turbo_b_to_a<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg1, v0, 0x2::coin::value<T1>(&arg0), 0, 4295048016, true, 0x2::tx_context::sender(arg5), arg2, arg4, arg3, arg5);
    }

    public fun turbo_helper<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::pay::keep<T1>(arg1, arg2);
        arg0
    }

    // decompiled from Move bytecode v6
}

