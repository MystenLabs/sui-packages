module 0xb55eea123e552f24983e12446ed8cad12a1ec923b42945771ed5a511c341d137::shrug {
    struct SHRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUG>(arg0, 6, b"SHRUG", b"SHARK IN HIS RUG", b"Just a Shark in his Rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_c6c0c664_1613_4461_8a5c_a4a07b07d259_305effa03f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

