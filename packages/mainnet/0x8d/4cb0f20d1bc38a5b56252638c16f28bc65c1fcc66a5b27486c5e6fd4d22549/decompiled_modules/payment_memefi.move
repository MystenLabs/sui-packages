module 0x8d4cb0f20d1bc38a5b56252638c16f28bc65c1fcc66a5b27486c5e6fd4d22549::payment_memefi {
    struct PaymentMemefiRegistry has key {
        id: 0x2::object::UID,
        nonces: 0x2::table::Table<u64, bool>,
        public_key: vector<u8>,
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
        amount: u64,
        userId: 0x1::string::String,
    }

    struct PAYMENT_MEMEFI has drop {
        dummy_field: bool,
    }

    fun assert_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0, &arg2), 13);
    }

    fun init(arg0: PAYMENT_MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentMemefiRegistry{
            id         : 0x2::object::new(arg1),
            nonces     : 0x2::table::new<u64, bool>(arg1),
            public_key : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<PaymentMemefiRegistry>(v0);
    }

    public fun is_nonce_used(arg0: &PaymentMemefiRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.nonces, arg1)
    }

    public fun pay(arg0: &mut PaymentMemefiRegistry, arg1: 0x2::coin::Coin<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_signature(arg2, arg4, arg3);
        let v0 = 0x2::bcs::new(arg3);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::coin::value<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>(&arg1);
        assert!(v2 == 0x2::bcs::peel_u64(&mut v0), 15);
        assert!(!0x2::table::contains<u64, bool>(&arg0.nonces, v1), 11);
        0x2::table::add<u64, bool>(&mut arg0.nonces, v1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>>(arg1, @0xb528d75685b950bfe53970b2f3644174b208e3bedd930b883e95482d25510759);
        let v3 = PaymentEvent{
            payer     : 0x2::tx_context::sender(arg5),
            recipient : @0xb528d75685b950bfe53970b2f3644174b208e3bedd930b883e95482d25510759,
            amount    : v2,
            nonce     : v1,
            userId    : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
        };
        0x2::event::emit<PaymentEvent>(v3);
    }

    public fun set_public_key(arg0: &mut PaymentMemefiRegistry, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0.public_key) == 0, 16);
        arg0.public_key = arg1;
    }

    // decompiled from Move bytecode v6
}

