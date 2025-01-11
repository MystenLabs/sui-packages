module 0xb5c6943f26c51a09e523a6f82914ee194c97e3b10cc4281910a37093597c73ac::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"ALICE AI by SuiAI", b"0100000101001100001100010100001101000101", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Nevtelen_859e69baf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

