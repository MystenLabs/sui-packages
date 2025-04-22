module 0xed4746d67ff3a5266fc1e0d4ea7f0f0d396474b5091c1a1c63a723f76997af52::tessx {
    struct TESSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESSX>(arg0, 9, b"TESSX", b"tezt1", b"sadfasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

