module 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::pay {
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

    struct PAY has drop {
        dummy_field: bool,
    }

    public fun pay(arg0: &mut PaymentRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 2000000000, 12);
        assert!(!0x2::table::contains<u64, bool>(&arg0.nonces, arg2), 11);
        0x2::table::add<u64, bool>(&mut arg0.nonces, arg2, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xb528d75685b950bfe53970b2f3644174b208e3bedd930b883e95482d25510759);
        let v0 = PaymentEvent{
            payer     : 0x2::tx_context::sender(arg4),
            recipient : @0xb528d75685b950bfe53970b2f3644174b208e3bedd930b883e95482d25510759,
            amount    : 2000000000,
            nonce     : arg2,
            userId    : arg3,
        };
        0x2::event::emit<PaymentEvent>(v0);
    }

    fun init(arg0: PAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentRegistry{
            id     : 0x2::object::new(arg1),
            nonces : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::share_object<PaymentRegistry>(v0);
    }

    public fun is_nonce_used(arg0: &PaymentRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.nonces, arg1)
    }

    // decompiled from Move bytecode v6
}

