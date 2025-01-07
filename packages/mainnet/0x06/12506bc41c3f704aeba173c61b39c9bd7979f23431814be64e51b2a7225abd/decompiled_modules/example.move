module 0x612506bc41c3f704aeba173c61b39c9bd7979f23431814be64e51b2a7225abd::example {
    struct LimitOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        pay_balance: 0x2::balance::Balance<T0>,
        target_balance: 0x2::balance::Balance<T1>,
        total_pay_amount: u64,
        obtained_amount: u64,
        claimed_amount: u64,
        created_ts: u64,
        expire_ts: u64,
        canceled_ts: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun place_limit_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u128, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = LimitOrder<T0, T1>{
            id               : 0x2::object::new(arg3),
            owner            : 0x2::tx_context::sender(arg3),
            pay_balance      : v0,
            target_balance   : 0x2::balance::zero<T1>(),
            total_pay_amount : 0x2::balance::value<T0>(&v0),
            obtained_amount  : 0,
            claimed_amount   : 0,
            created_ts       : 0x2::tx_context::epoch_timestamp_ms(arg3),
            expire_ts        : arg2,
            canceled_ts      : 0,
        };
        0x2::transfer::transfer<LimitOrder<T0, T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

