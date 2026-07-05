module 0x46fa5f3fa70d0ebeb61c39ffa3f4bb47fbba8cdc136c2e734053656adcdf0132::hedge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun close_hedge_and_take_profit(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun supply_and_hedge<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

