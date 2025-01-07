module 0x405de3e1c0084ccb84947fe309662dbf30e9f989f307481ba395ef1738a2a9ab::andysui {
    struct ANDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDYSUI>(arg0, 6, b"ANDYSUI", b"ANDY SUI", b"I am Andy. Pepe's best friend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Andrew_Tate_5_dc0fb404e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

