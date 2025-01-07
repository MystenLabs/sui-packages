module 0x324c3f9e2605bd03d2f838bc4f61612e817efbe2c29c9ffd6c3eeadb955c71ff::teary {
    struct TEARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEARY>(arg0, 6, b"Teary", b"Project Teary Eye", b"This is the token created for members of team teary eye. Holders will have access to Genesis Aeon NFT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/teary_eye_42a4f30a05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

