module 0x51492e3c9ef86f12b73d652be2aa05aaed0b29ca924efb16564cd9f3eb517492::pugwrap {
    struct PUGWRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWRAP>(arg0, 6, b"PUGWRAP", b"PugWifWrap", b"cutest wrapped sui pug would u eat her?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7114_e520a8c53f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWRAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWRAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

