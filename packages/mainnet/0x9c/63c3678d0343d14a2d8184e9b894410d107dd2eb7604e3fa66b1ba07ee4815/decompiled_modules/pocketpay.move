module 0x9c63c3678d0343d14a2d8184e9b894410d107dd2eb7604e3fa66b1ba07ee4815::pocketpay {
    struct PaymentDetails has store, key {
        id: 0x2::object::UID,
        order_id: u64,
        amount: u64,
    }

    struct PaymentDetailsEvent has copy, drop {
        order_id: u64,
        amount: u64,
    }

    public entry fun create_tx<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v0 = PaymentDetails{
            id       : 0x2::object::new(arg4),
            order_id : arg3,
            amount   : arg2,
        };
        let v1 = PaymentDetailsEvent{
            order_id : arg3,
            amount   : arg2,
        };
        0x2::event::emit<PaymentDetailsEvent>(v1);
        0x2::transfer::transfer<PaymentDetails>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

