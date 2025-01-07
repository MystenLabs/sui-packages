module 0xbda2096daf150d4f3f5fecb2b997c288695254a038cc2c8e9cade29d3f4b34b1::vqo {
    struct VQO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VQO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VQO>(arg0, 6, b"VQO", b"meme VQO", b"Starting with VQO. a meme token on sui. and follow the journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Token_Foto_58fb305199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VQO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VQO>>(v1);
    }

    // decompiled from Move bytecode v6
}

