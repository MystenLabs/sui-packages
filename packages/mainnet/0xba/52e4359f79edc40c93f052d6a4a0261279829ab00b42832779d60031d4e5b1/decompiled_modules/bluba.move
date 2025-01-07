module 0xba52e4359f79edc40c93f052d6a4a0261279829ab00b42832779d60031d4e5b1::bluba {
    struct BLUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBA>(arg0, 6, b"BLUBA", b"BLUBAAA", b"BLUBA is the sister of BLUB, she's super high!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2_1d40b81135.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

