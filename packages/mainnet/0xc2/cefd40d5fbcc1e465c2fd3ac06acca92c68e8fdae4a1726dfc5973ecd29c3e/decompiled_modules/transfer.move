module 0xc2cefd40d5fbcc1e465c2fd3ac06acca92c68e8fdae4a1726dfc5973ecd29c3e::transfer {
    struct PaymentEvent<phantom T0> has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        note: 0x1::option::Option<0x1::string::String>,
    }

    struct TransferObjectEvent<phantom T0: store + key> has copy, drop {
        sender: address,
        receiver: address,
        note: 0x1::option::Option<0x1::string::String>,
    }

    public fun make_payment<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v0 = PaymentEvent<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            receiver : arg1,
            amount   : 0x2::coin::value<T0>(&arg0),
            note     : arg2,
        };
        0x2::event::emit<PaymentEvent<T0>>(v0);
    }

    public fun transfer_object<T0: store + key>(arg0: T0, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
        let v0 = TransferObjectEvent<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            receiver : arg1,
            note     : arg2,
        };
        0x2::event::emit<TransferObjectEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

