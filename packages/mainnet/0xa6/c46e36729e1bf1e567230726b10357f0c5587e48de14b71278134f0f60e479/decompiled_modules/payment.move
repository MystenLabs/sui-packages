module 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::payment {
    struct PaymentRecipt has copy, drop {
        sender: address,
        currency: 0x1::type_name::TypeName,
        amount: u64,
        receipt: 0x1::ascii::String,
    }

    public fun pay<T0>(arg0: &0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::payment_registry::PaymentRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::payment_registry::is_supported_currency<T0>(arg0), 9223372157113860097);
        let v0 = PaymentRecipt{
            sender   : 0x2::tx_context::sender(arg3),
            currency : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg1),
            receipt  : arg2,
        };
        0x2::event::emit<PaymentRecipt>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::payment_registry::to_address(arg0));
    }

    // decompiled from Move bytecode v6
}

