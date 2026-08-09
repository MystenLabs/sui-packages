module 0x11e76d85ca09d67b2286b156c80354790c64e156ef559852a04d923b649b8430::guard {
    struct Receipt<phantom T0> {
        amount_in: u64,
        min_profit: u64,
    }

    struct ProfitConfirmed<phantom T0> has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
    }

    public fun begin<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : Receipt<T0> {
        Receipt<T0>{
            amount_in  : 0x2::coin::value<T0>(arg0),
            min_profit : arg1,
        }
    }

    public fun confirm<T0>(arg0: Receipt<T0>, arg1: &0x2::coin::Coin<T0>) {
        let Receipt {
            amount_in  : v0,
            min_profit : v1,
        } = arg0;
        let v2 = 0x2::coin::value<T0>(arg1);
        assert!(v2 >= v0 + v1, 0);
        let v3 = ProfitConfirmed<T0>{
            amount_in  : v0,
            amount_out : v2,
            profit     : v2 - v0,
        };
        0x2::event::emit<ProfitConfirmed<T0>>(v3);
    }

    // decompiled from Move bytecode v7
}

