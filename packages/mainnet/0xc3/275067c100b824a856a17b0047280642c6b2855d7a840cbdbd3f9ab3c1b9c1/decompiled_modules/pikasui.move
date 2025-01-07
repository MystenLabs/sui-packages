module 0xc3275067c100b824a856a17b0047280642c6b2855d7a840cbdbd3f9ab3c1b9c1::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 6, b"PIKASUI", b"pikapikasui", b"pikasui on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c1cce2b77bac11eebbd0e6d39d9a42a4_upscaled_fdc6df6a31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

