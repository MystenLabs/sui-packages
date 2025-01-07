module 0x5d9f756d73da1d717c80bc8d566101ab97553190830ed524390a228b68482ace::bitmog {
    struct BITMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMOG>(arg0, 6, b"BITMOG", b"EightBit Mog on Sui", b"First GameFi on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lgnobgfinal_ee4459b05c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

