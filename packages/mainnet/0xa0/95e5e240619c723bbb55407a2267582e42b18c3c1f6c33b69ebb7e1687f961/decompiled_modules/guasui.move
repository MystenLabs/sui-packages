module 0xa095e5e240619c723bbb55407a2267582e42b18c3c1f6c33b69ebb7e1687f961::guasui {
    struct GUASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUASUI>(arg0, 6, b"GUASUI", b"GUA", b"GUA SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_01_45_10_42f620c35c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

