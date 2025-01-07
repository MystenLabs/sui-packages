module 0x6b9ed0805f0717116e73f7ba95820494c6cb9f5aee47bf1b99ea619070aa02fe::specialsuidog {
    struct SPECIALSUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPECIALSUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPECIALSUIDOG>(arg0, 6, b"specialSuidog", b"speial sui dog", b"Special Sui dog will list many exchange. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_meme_77058a1c29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPECIALSUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPECIALSUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

