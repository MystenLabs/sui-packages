module 0xdbb041b46f1c7a9fe2271db09fbda5acd63bfe367276ed78974f3abc24a210d1::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"FROGGY", b"Froggy", b"Im a frog, a real one. A frog who loves betting, which is why I wanted to make that deal with you. I bet you already lost jeeter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_25_T181843_639_7c60dc6ff5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

