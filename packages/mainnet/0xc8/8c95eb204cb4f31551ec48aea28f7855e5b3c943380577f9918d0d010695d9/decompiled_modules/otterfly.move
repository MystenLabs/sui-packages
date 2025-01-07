module 0xc88c95eb204cb4f31551ec48aea28f7855e5b3c943380577f9918d0d010695d9::otterfly {
    struct OTTERFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTERFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTERFLY>(arg0, 6, b"OTTERFLY", b"OTTERFLY SUI", x"5468697320697320244f5446244f54544552464c59206120666c79696e67206f747465722066726f6d207570746f6265722077697468206d616e792061646f7261626c652066616369616c2065787072657373696f6e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_23_39_37_b1894ea6bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTERFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTERFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

