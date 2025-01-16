module 0x1ae45377e71778b36694bd739682d940a20a33599bb2fd1f765ac8450cfa30d2::wummy {
    struct WUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUMMY>(arg0, 6, b"WUMMY", b"wummy on sui", b"WUMMY inspired by Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000133725_41ffa9a075.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

