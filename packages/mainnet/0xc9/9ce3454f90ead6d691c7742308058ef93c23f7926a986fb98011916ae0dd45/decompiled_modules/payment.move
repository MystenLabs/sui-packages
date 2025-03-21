module 0xc99ce3454f90ead6d691c7742308058ef93c23f7926a986fb98011916ae0dd45::payment {
    struct PaymentRecipt has copy, drop {
        sender: address,
        currency: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun pay<T0>(arg0: &0xc99ce3454f90ead6d691c7742308058ef93c23f7926a986fb98011916ae0dd45::payment_registry::PaymentRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc99ce3454f90ead6d691c7742308058ef93c23f7926a986fb98011916ae0dd45::payment_registry::is_supported_currency<T0>(arg0), 9223372127049089025);
        let v0 = PaymentRecipt{
            sender   : 0x2::tx_context::sender(arg2),
            currency : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<PaymentRecipt>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xc99ce3454f90ead6d691c7742308058ef93c23f7926a986fb98011916ae0dd45::payment_registry::to_address(arg0));
    }

    // decompiled from Move bytecode v6
}

