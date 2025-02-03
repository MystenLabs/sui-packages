module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::send {
    public fun transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_send::emit_send_event(0x2::tx_context::sender(arg2), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg0), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

