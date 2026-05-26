module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::receipt {
    struct RECEIPT has drop {
        dummy_field: bool,
    }

    struct PaymentReceipt has store, key {
        id: 0x2::object::UID,
        from: address,
        to: address,
        amount: u64,
        asset: 0x1::string::String,
        memo: 0x1::string::String,
        ts_ms: u64,
    }

    struct ReceiptMinted has copy, drop {
        id: 0x2::object::ID,
        from: address,
        to: address,
        amount: u64,
        asset: 0x1::string::String,
        ts_ms: u64,
    }

    public fun amount(arg0: &PaymentReceipt) : u64 {
        arg0.amount
    }

    public fun asset(arg0: &PaymentReceipt) : &0x1::string::String {
        &arg0.asset
    }

    public fun from(arg0: &PaymentReceipt) : address {
        arg0.from
    }

    fun init(arg0: RECEIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RECEIPT>(arg0, arg1);
        let v1 = 0x2::display::new<PaymentReceipt>(&v0, arg1);
        0x2::display::add<PaymentReceipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Talise receipt"));
        0x2::display::add<PaymentReceipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"On-chain proof of a Talise payment."));
        0x2::display::add<PaymentReceipt>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://talise.io/r/{id}"));
        0x2::display::add<PaymentReceipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://talise.io/r/{id}/og.png"));
        0x2::display::add<PaymentReceipt>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://talise.io"));
        0x2::display::update_version<PaymentReceipt>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PaymentReceipt>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun memo(arg0: &PaymentReceipt) : &0x1::string::String {
        &arg0.memo
    }

    public(friend) fun mint(arg0: address, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : PaymentReceipt {
        let v0 = PaymentReceipt{
            id     : 0x2::object::new(arg6),
            from   : arg0,
            to     : arg1,
            amount : arg2,
            asset  : arg3,
            memo   : arg4,
            ts_ms  : arg5,
        };
        let v1 = ReceiptMinted{
            id     : 0x2::object::id<PaymentReceipt>(&v0),
            from   : arg0,
            to     : arg1,
            amount : arg2,
            asset  : arg3,
            ts_ms  : arg5,
        };
        0x2::event::emit<ReceiptMinted>(v1);
        v0
    }

    public fun to(arg0: &PaymentReceipt) : address {
        arg0.to
    }

    public fun ts_ms(arg0: &PaymentReceipt) : u64 {
        arg0.ts_ms
    }

    // decompiled from Move bytecode v7
}

