module 0x79747b0778d878d1865aab3846cbeb69f2afb96c468bdec928f64aafd2e616a5::bitk {
    struct BITK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BITK>(arg0, 6, b"BITK", b"bitcoin120k by SuiAI", b"vamos comemorar os 120k do bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bicoin120k_e1ded6a499.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

