module 0xa9833a98e07efc840462942798dfb4f85595878273d2313f64e858c451b96104::aped {
    struct APED has drop {
        dummy_field: bool,
    }

    fun init(arg0: APED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APED>(arg0, 6, b"Aped", b"ngl I aped", x"6e676c204920617065642074686973206d656d65636f696e0a0a49206372656174652074656c656772616d20616e642058207768656e20736f6d652070656f706c6520626f75676874", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6234_32b611a51b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APED>>(v1);
    }

    // decompiled from Move bytecode v6
}

