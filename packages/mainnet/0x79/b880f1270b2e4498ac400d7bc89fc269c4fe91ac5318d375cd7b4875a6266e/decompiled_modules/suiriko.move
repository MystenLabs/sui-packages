module 0x79b880f1270b2e4498ac400d7bc89fc269c4fe91ac5318d375cd7b4875a6266e::suiriko {
    struct SUIRIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIKO>(arg0, 6, b"SuiRIKO", b"RIKO", b"Riko isn't an investment; it's a meme coin. Don't expect returns, expect laughs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/31_b1afc2a85e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

