module 0x4ec32f4a025cb9a6e61d872ee5c5373d1767ffdc2cb4573fb52b2a375682c5bd::payment {
    struct PaymentRegistry has key {
        id: 0x2::object::UID,
        nonces: 0x2::table::Table<u64, bool>,
    }

    struct PaymentEvent has copy, drop {
        payer: address,
        recipient: address,
        amount: u64,
        nonce: u64,
        userId: 0x1::string::String,
    }

    struct PaymentMessage has copy, drop {
        nonce: u64,
        userId: 0x1::string::String,
        amount: u64,
        payer: address,
    }

    struct PAYMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentRegistry{
            id     : 0x2::object::new(arg1),
            nonces : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::share_object<PaymentRegistry>(v0);
    }

    public fun is_nonce_used(arg0: &PaymentRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.nonces, arg1)
    }

    public fun pay(arg0: &mut PaymentRegistry, arg1: 0x2::coin::Coin<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>, arg2: u64, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>(&arg1);
        assert!(!0x2::table::contains<u64, bool>(&arg0.nonces, arg2), 11);
        0x2::table::add<u64, bool>(&mut arg0.nonces, arg2, true);
        let v2 = PaymentMessage{
            nonce  : arg2,
            userId : arg3,
            amount : v1,
            payer  : v0,
        };
        let v3 = 0x2::bcs::to_bytes<PaymentMessage>(&v2);
        let v4 = b"162c4b1548a7f470d9a19c1061a30c3d3aaae5a2214d54c71422d44b0ab4b703";
        assert!(0x2::ed25519::ed25519_verify(&arg4, &v4, &v3), 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>>(arg1, @0xb528d75685b950bfe53970b2f3644174b208e3bedd930b883e95482d25510759);
        let v5 = PaymentEvent{
            payer     : v0,
            recipient : @0xb528d75685b950bfe53970b2f3644174b208e3bedd930b883e95482d25510759,
            amount    : v1,
            nonce     : arg2,
            userId    : arg3,
        };
        0x2::event::emit<PaymentEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

