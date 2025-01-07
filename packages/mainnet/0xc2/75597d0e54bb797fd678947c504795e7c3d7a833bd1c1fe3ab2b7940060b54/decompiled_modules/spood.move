module 0xc275597d0e54bb797fd678947c504795e7c3d7a833bd1c1fe3ab2b7940060b54::spood {
    struct SPOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOD>(arg0, 6, b"SPOOD", b"SPOODER SUI", b"SPOODER ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1x1_1e41078209.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

