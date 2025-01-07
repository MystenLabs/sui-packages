module 0xa48a7bcccbdffcfa9721de0c09eefe0d1f51d2bf47337869069edb036c973584::bleach {
    public fun destroy_account_cap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0xdee9::custodian_v2::AccountCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _, v2, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, &arg1);
        let v4 = if (v2 > 0) {
            0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v2, &arg1, arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        };
        let v5 = if (v0 > 0) {
            0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v0, &arg1, arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        };
        0xdee9::custodian_v2::delete_account_cap(arg1);
        (v5, v4)
    }

    public fun market_prices<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        let v4 = 0x1::option::destroy_some<u64>(v3);
        let v5 = 0x1::option::destroy_some<u64>(v2);
        let v6 = 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        assert!(v5 - v4 > v6, 408);
        (v4 + v6, v5 - v6)
    }

    public fun quote_quantity(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 1000000000
    }

    // decompiled from Move bytecode v6
}

