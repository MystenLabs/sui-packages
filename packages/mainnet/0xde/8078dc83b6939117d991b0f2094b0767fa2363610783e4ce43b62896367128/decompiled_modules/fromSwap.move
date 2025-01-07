module 0xde8078dc83b6939117d991b0f2094b0767fa2363610783e4ce43b62896367128::fromSwap {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    public fun dex_finalize_with_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 < arg1) {
            abort 3
        };
        let v1 = OrderRecord{
            order_id   : arg2,
            decimal    : arg3,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        arg0
    }

    // decompiled from Move bytecode v6
}

