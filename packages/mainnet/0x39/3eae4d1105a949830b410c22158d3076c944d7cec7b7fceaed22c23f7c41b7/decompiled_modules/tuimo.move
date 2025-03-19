module 0x393eae4d1105a949830b410c22158d3076c944d7cec7b7fceaed22c23f7c41b7::tuimo {
    struct TUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUIMO>(arg0, 6, b"TUIMO", b"TUI MO", b"Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000579_f733bd0481.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

