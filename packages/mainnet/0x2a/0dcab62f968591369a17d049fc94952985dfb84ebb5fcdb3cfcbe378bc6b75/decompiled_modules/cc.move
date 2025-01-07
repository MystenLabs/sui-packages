module 0x2a0dcab62f968591369a17d049fc94952985dfb84ebb5fcdb3cfcbe378bc6b75::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 6, b"CC", b"cough cat", b"aaaaaaaawwwccccccccck!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_8_45374ea4c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    // decompiled from Move bytecode v6
}

