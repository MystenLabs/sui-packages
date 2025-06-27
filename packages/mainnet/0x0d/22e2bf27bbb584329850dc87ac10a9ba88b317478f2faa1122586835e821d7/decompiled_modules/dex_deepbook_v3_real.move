module 0xd22e2bf27bbb584329850dc87ac10a9ba88b317478f2faa1122586835e821d7::dex_deepbook_v3_real {
    struct RealDeepBookV3SwapExecuted has copy, drop {
        order_book: address,
        is_bid: bool,
        amount_in: u64,
        amount_out: u64,
        avg_price: u64,
        success: bool,
    }

    fun calculate_market_impact(arg0: u64, arg1: address) : u64 {
        if (arg1 == @0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33) {
            if (arg0 > 10000000000) {
                50
            } else if (arg0 > 1000000000) {
                20
            } else {
                5
            }
        } else if (arg0 > 1000000000) {
            80
        } else if (arg0 > 100000000) {
            40
        } else {
            10
        }
    }

    public fun get_deepbook_v3_order_books() : (address, address) {
        (@0x4405b50d791fd3346754e8171aaab6bc2ed26c2c46efdd033c14b30ae507ac33, @0xb663828d7e3f0c178867f30c3e72e40b73ce42be87f87a45949f3ee7c8ce0fb2)
    }

    public fun is_deepbook_v3_ready() : bool {
        false
    }

    public fun place_limit_order_v3<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 802);
        0x2::coin::destroy_zero<T0>(arg1);
        (0x2::clock::timestamp_ms(arg5) as u128) << 64 | (v0 as u128)
    }

    public fun swap_market_v3_real<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 802);
        let v1 = v0 - v0 * 10 / 10000;
        let v2 = v1 - v1 * calculate_market_impact(v0, arg0) / 10000;
        assert!(v2 >= arg3, 803);
        let v3 = if (v2 > 0) {
            v0 * 1000000 / v2
        } else {
            1000000
        };
        let v4 = RealDeepBookV3SwapExecuted{
            order_book : arg0,
            is_bid     : arg2,
            amount_in  : v0,
            amount_out : v2,
            avg_price  : v3,
            success    : false,
        };
        0x2::event::emit<RealDeepBookV3SwapExecuted>(v4);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::zero<T1>(arg5)
    }

    public fun swap_two_way<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2, 805);
        swap_market_v3_real<T0, T1>(arg0, arg1, false, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

