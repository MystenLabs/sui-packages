module 0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::fromSwap {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    public fun dex_finalize_with_return<T0>(arg0: &0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::check_xbridge_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 < arg2) {
            abort 3
        };
        let v1 = OrderRecord{
            order_id   : arg3,
            decimal    : arg4,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        arg1
    }

    // decompiled from Move bytecode v6
}

