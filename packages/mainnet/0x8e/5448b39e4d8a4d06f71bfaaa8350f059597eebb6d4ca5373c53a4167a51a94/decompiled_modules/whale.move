module 0x8e5448b39e4d8a4d06f71bfaaa8350f059597eebb6d4ca5373c53a4167a51a94::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"SuiWhale", b"Graduated on SuiWhale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiwhale.live/api/images/bfeaddf2-d1e7-417c-a2e9-1ce2e0953e29.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

