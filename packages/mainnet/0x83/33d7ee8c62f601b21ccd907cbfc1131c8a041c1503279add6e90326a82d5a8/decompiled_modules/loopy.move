module 0x8333d7ee8c62f601b21ccd907cbfc1131c8a041c1503279add6e90326a82d5a8::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"LOOPY", b"SuiLoopy", b" We can do it because we are cute!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/000_0cfc0bc7a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

