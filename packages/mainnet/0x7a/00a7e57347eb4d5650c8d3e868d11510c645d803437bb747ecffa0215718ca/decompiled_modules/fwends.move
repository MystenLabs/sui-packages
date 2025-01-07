module 0x7a00a7e57347eb4d5650c8d3e868d11510c645d803437bb747ecffa0215718ca::fwends {
    struct FWENDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWENDS>(arg0, 6, b"Fwends", b"MEME FWENDS", b"FWENDS ON SUI, 100% meme pure ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3715_315d9932f3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWENDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWENDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

