module 0xa909e9f8e49f1b604c30a03c0ff87e37574445866376b3a704aee1d3c8065eaa::guard {
    struct Receipt<phantom T0> {
        route_id: u32,
        amount_in: u64,
        min_profit: u64,
    }

    struct InspectReceipt<phantom T0> {
        route_id: u32,
        amount_in: u64,
        quoted_amount_out: u64,
    }

    struct ArbitrageExecuted<phantom T0> has copy, drop {
        executor: address,
        route_id: u32,
        amount_in: u64,
        amount_out: u64,
        min_profit: u64,
        profit: u64,
    }

    struct ArbitrageInspected<phantom T0> has copy, drop {
        executor: address,
        route_id: u32,
        amount_in: u64,
        quoted_amount_out: u64,
        amount_out: u64,
        profitable: bool,
        profit: u64,
        loss: u64,
        quote_above_actual: bool,
        quote_delta: u64,
    }

    public fun amount_in<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.amount_in
    }

    public fun begin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: u64) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        assert!(v0 <= 18446744073709551615 - arg2, 1);
        let v1 = Receipt<T0>{
            route_id   : arg1,
            amount_in  : v0,
            min_profit : arg2,
        };
        (arg0, v1)
    }

    public fun finish<T0>(arg0: 0x2::coin::Coin<T0>, arg1: Receipt<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Receipt {
            route_id   : v0,
            amount_in  : v1,
            min_profit : v2,
        } = arg1;
        let v3 = 0x2::coin::value<T0>(&arg0);
        assert!(v3 >= v1 + v2, 2);
        let v4 = ArbitrageExecuted<T0>{
            executor   : 0x2::tx_context::sender(arg2),
            route_id   : v0,
            amount_in  : v1,
            amount_out : v3,
            min_profit : v2,
            profit     : v3 - v1,
        };
        0x2::event::emit<ArbitrageExecuted<T0>>(v4);
        arg0
    }

    public fun inspect_begin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u32, arg2: u64) : (0x2::coin::Coin<T0>, InspectReceipt<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = InspectReceipt<T0>{
            route_id          : arg1,
            amount_in         : v0,
            quoted_amount_out : arg2,
        };
        (arg0, v1)
    }

    public fun inspect_finish<T0>(arg0: 0x2::coin::Coin<T0>, arg1: InspectReceipt<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let InspectReceipt {
            route_id          : v0,
            amount_in         : v1,
            quoted_amount_out : v2,
        } = arg1;
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = v3 >= v1;
        let v5 = if (v4) {
            v3 - v1
        } else {
            0
        };
        let v6 = if (v4) {
            0
        } else {
            v1 - v3
        };
        let v7 = v2 >= v3;
        let v8 = if (v7) {
            v2 - v3
        } else {
            v3 - v2
        };
        let v9 = ArbitrageInspected<T0>{
            executor           : 0x2::tx_context::sender(arg2),
            route_id           : v0,
            amount_in          : v1,
            quoted_amount_out  : v2,
            amount_out         : v3,
            profitable         : v4,
            profit             : v5,
            loss               : v6,
            quote_above_actual : v7,
            quote_delta        : v8,
        };
        0x2::event::emit<ArbitrageInspected<T0>>(v9);
        arg0
    }

    public fun min_profit<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.min_profit
    }

    public fun route_id<T0>(arg0: &Receipt<T0>) : u32 {
        arg0.route_id
    }

    // decompiled from Move bytecode v7
}

