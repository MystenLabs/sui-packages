module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::send {
    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        assert!(0x1::string::length(&arg3) <= 80, 2);
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::receipt::PaymentReceipt>(0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::receipt::mint(v1, arg1, v0, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

