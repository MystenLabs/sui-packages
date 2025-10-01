module 0xb0f21e0466f8fb85e49eb68e75f2bdd80c7e6088f0ee24f21730d0bbc3a1cb3e::payment {
    struct PaymentRecipt has copy, drop {
        sender: address,
        currency: 0x1::type_name::TypeName,
        amount: u64,
        receipt: 0x1::string::String,
    }

    public fun pay<T0>(arg0: &0xb0f21e0466f8fb85e49eb68e75f2bdd80c7e6088f0ee24f21730d0bbc3a1cb3e::payment_registry::PaymentRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb0f21e0466f8fb85e49eb68e75f2bdd80c7e6088f0ee24f21730d0bbc3a1cb3e::payment_registry::is_supported_currency<T0>(arg0), 13906834294602465281);
        let v0 = PaymentRecipt{
            sender   : 0x2::tx_context::sender(arg3),
            currency : 0x1::type_name::with_defining_ids<T0>(),
            amount   : 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1)),
            receipt  : arg2,
        };
        0x2::event::emit<PaymentRecipt>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xb0f21e0466f8fb85e49eb68e75f2bdd80c7e6088f0ee24f21730d0bbc3a1cb3e::payment_registry::recipiment(arg0));
    }

    // decompiled from Move bytecode v6
}

