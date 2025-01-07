module 0xedc29f95f9f082ebaf8eb396828cc7fd7940870bc7b0ac63bcc189a8150c03a8::testify {
    struct TESTIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTIFY>(arg0, 6, b"TESTIFY", b"Test", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_logo_068e73f094.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

