module 0x73cd76168d3cca0f502849ab026c7678cfe51f51dea5d64c87f844c71924fab0::transfer {
    struct TransferCoinEvent<phantom T0> has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        note: 0x1::string::String,
    }

    struct TransferObjectEvent<phantom T0: store + key> has copy, drop {
        sender: address,
        receiver: address,
        note: 0x1::string::String,
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        let v0 = TransferCoinEvent<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            receiver : arg1,
            amount   : 0x2::coin::value<T0>(&arg0),
            note     : arg2,
        };
        0x2::event::emit<TransferCoinEvent<T0>>(v0);
    }

    public fun transfer_object<T0: store + key>(arg0: T0, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
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

