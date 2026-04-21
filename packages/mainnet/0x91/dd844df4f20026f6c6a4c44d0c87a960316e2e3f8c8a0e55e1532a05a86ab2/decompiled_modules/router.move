module 0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router {
    struct HopSwapEvent has copy, drop {
        amount_in: u64,
        amount_out: u64,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
    }

    struct HopReceipt has store {
        amount_in: u64,
        min_out: u64,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
    }

    public fun amount_in(arg0: &HopReceipt) : u64 {
        arg0.amount_in
    }

    public fun coin_in(arg0: &HopReceipt) : 0x1::type_name::TypeName {
        arg0.coin_in
    }

    public fun coin_out(arg0: &HopReceipt) : 0x1::type_name::TypeName {
        arg0.coin_out
    }

    public fun end<T0>(arg0: HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(end_returns<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun end_returns<T0>(arg0: HopReceipt, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        let HopReceipt {
            amount_in : v0,
            min_out   : v1,
            coin_in   : v2,
            coin_out  : v3,
        } = arg0;
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 >= v1, 0);
        assert!(v3 == 0x1::type_name::get<T0>(), 1);
        let v5 = HopSwapEvent{
            amount_in  : v0,
            amount_out : v4,
            coin_in    : v2,
            coin_out   : v3,
        };
        0x2::event::emit<HopSwapEvent>(v5);
        arg1
    }

    public fun min_out(arg0: &HopReceipt) : u64 {
        arg0.min_out
    }

    public fun start<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : (0x2::coin::Coin<T0>, HopReceipt) {
        let v0 = HopReceipt{
            amount_in : 0x2::coin::value<T0>(&arg0),
            min_out   : arg1,
            coin_in   : 0x1::type_name::get<T0>(),
            coin_out  : 0x1::type_name::get<T1>(),
        };
        (arg0, v0)
    }

    // decompiled from Move bytecode v6
}

