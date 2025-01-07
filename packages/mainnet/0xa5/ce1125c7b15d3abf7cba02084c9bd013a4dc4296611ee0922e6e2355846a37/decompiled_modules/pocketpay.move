module 0xa5ce1125c7b15d3abf7cba02084c9bd013a4dc4296611ee0922e6e2355846a37::pocketpay {
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

