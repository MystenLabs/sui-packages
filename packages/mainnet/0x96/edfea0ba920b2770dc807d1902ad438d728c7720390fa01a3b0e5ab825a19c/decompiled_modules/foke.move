module 0x96edfea0ba920b2770dc807d1902ad438d728c7720390fa01a3b0e5ab825a19c::foke {
    struct FOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOKE>(arg0, 6, b"FOKE", b"Foke On Sui", b"I'm FOKE, a Terra Luna crash survivor who bet it all on Solana and turned into a mega whale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048529_0abdf8676b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

