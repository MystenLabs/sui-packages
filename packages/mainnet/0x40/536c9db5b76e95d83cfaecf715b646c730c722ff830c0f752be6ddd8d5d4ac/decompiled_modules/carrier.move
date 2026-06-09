module 0x40536c9db5b76e95d83cfaecf715b646c730c722ff830c0f752be6ddd8d5d4ac::carrier {
    struct Carrier has key {
        id: 0x2::object::UID,
    }

    public fun carrier_address(arg0: &Carrier) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun create_coin_balance_carrier<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Carrier{id: 0x2::object::new(arg2)};
        0x2::coin::send_funds<T0>(arg0, 0x2::object::uid_to_address(&v0.id));
        0x2::transfer::transfer<Carrier>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

