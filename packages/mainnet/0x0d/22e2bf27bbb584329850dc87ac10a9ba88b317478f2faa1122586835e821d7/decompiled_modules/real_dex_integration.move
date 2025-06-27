module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::real_dex_integration {
    struct RealArbitrageExecuted has copy, drop {
        dex1: u8,
        dex2: u8,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        success: bool,
    }

    struct IntegrationStatus has copy, drop {
        bluefin_ready: bool,
        kriya_ready: bool,
        aftermath_ready: bool,
        total_tvl_accessible: u64,
    }

    public entry fun arb_aftermath_bluefin_real<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::swap_real<T1, T0>(0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::get_bluefin_pool_address(), 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_real::swap_simple<T0, T1>(arg0, 0, arg3, arg4), v0 + arg1, false, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        let v4 = RealArbitrageExecuted{
            dex1       : 3,
            dex2       : 1,
            amount_in  : v0,
            amount_out : v2,
            profit     : v3,
            success    : v3 >= arg1,
        };
        0x2::event::emit<RealArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun arb_bluefin_kriya_real<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::swap_real<T0, T1>(0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::get_bluefin_pool_address(), arg0, 0, true, arg4);
        0x2::coin::value<T1>(&v1);
        let (v2, _) = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real::get_kriya_pool_info();
        let v4 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real::swap_real<T1, T0>(v2, v1, v0 + arg1, false, arg4);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = if (v5 > v0) {
            v5 - v0
        } else {
            0
        };
        let v7 = RealArbitrageExecuted{
            dex1       : 1,
            dex2       : 2,
            amount_in  : v0,
            amount_out : v5,
            profit     : v6,
            success    : v6 >= arg1,
        };
        0x2::event::emit<RealArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
    }

    public entry fun arb_kriya_aftermath_real<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, _) = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real::get_kriya_pool_info();
        let v3 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_real::swap_simple<T1, T0>(0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real::swap_real<T0, T1>(v1, arg0, 0, true, arg4), v0 + arg1, arg3, arg4);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        let v6 = RealArbitrageExecuted{
            dex1       : 2,
            dex2       : 3,
            amount_in  : v0,
            amount_out : v4,
            profit     : v5,
            success    : v5 >= arg1,
        };
        0x2::event::emit<RealArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg4));
    }

    public entry fun arb_three_way_real<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, _) = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real::get_kriya_pool_info();
        let v3 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_aftermath_real::swap_simple<T0, T0>(0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_kriya_real::swap_real<T1, T0>(v1, 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::swap_real<T0, T1>(0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::get_bluefin_pool_address(), arg0, 0, true, arg4), 0, false, arg4), v0 + arg1, arg3, arg4);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        let v6 = RealArbitrageExecuted{
            dex1       : 1,
            dex2       : 2,
            amount_in  : v0,
            amount_out : v4,
            profit     : v5,
            success    : v5 >= arg1,
        };
        0x2::event::emit<RealArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun calculate_best_route(arg0: u64, arg1: vector<u64>) : (u8, u8, u64) {
        (1, 2, arg0)
    }

    public entry fun check_integration_status(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_bluefin_real::is_real_integration_ready();
        let v1 = false;
        let v2 = false;
        let v3 = if (v0) {
            0 + 25000000
        } else {
            0
        };
        let v4 = if (v1) {
            v3 + 20000000
        } else {
            v3
        };
        let v5 = if (v2) {
            v4 + 15000000
        } else {
            v4
        };
        let v6 = IntegrationStatus{
            bluefin_ready        : v0,
            kriya_ready          : v1,
            aftermath_ready      : v2,
            total_tvl_accessible : v5,
        };
        0x2::event::emit<IntegrationStatus>(v6);
    }

    // decompiled from Move bytecode v6
}

