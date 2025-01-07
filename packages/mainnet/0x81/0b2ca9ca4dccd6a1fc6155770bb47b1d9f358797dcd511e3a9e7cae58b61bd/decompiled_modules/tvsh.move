module 0x810b2ca9ca4dccd6a1fc6155770bb47b1d9f358797dcd511e3a9e7cae58b61bd::tvsh {
    struct TVSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVSH>(arg0, 6, b"TvsH", b"Trump vs Harris", b"Trump vs. Harris: How rhetorical framing could decide the 2024 election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1778_4a7f3cb301.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

