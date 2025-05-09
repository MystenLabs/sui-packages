module 0x5b9f3c2a8889d822974add803433c4b11628dcb0915e7291e66b43ff77787834::sola {
    struct SOLA has drop {
        dummy_field: bool,
    }

    struct Sola<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        chat_fee: u64,
        version: u64,
    }

    struct MessageEvent has copy, drop {
        sender: address,
        username: 0x1::string::String,
        message: 0x1::string::String,
    }

    struct DonateEvent has copy, drop {
        sender: address,
        username: 0x1::string::String,
        message: 0x1::string::String,
        amount: u64,
    }

    public entry fun donate<T0>(arg0: &mut Sola<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = DonateEvent{
            sender   : 0x2::tx_context::sender(arg4),
            username : arg2,
            message  : arg3,
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DonateEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
    }

    public entry fun init_sola<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x2cb597ed6f3574a21213b743290185cc9736ae95c0cc21ce0af48ca15dfb9e78, 2);
        let v0 = Sola<T0>{
            id       : 0x2::object::new(arg0),
            admin    : @0x2cb597ed6f3574a21213b743290185cc9736ae95c0cc21ce0af48ca15dfb9e78,
            chat_fee : 6900000,
            version  : 1,
        };
        0x2::transfer::share_object<Sola<T0>>(v0);
    }

    public entry fun send_message<T0>(arg0: &mut Sola<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.chat_fee, 1);
        let v0 = MessageEvent{
            sender   : 0x2::tx_context::sender(arg4),
            username : arg2,
            message  : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
    }

    // decompiled from Move bytecode v6
}

