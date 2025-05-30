module 0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment {
    struct PaymentRecipt has copy, drop {
        sender: address,
        currency: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun pay<T0>(arg0: &0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_registry::PaymentRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_registry::is_supported_currency<T0>(arg0), 9223372127049089025);
        let v0 = PaymentRecipt{
            sender   : 0x2::tx_context::sender(arg2),
            currency : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<PaymentRecipt>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_registry::to_address(arg0));
    }

    // decompiled from Move bytecode v6
}

