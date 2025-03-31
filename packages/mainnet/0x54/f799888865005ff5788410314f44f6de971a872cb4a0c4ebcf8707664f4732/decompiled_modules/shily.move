module 0x54f799888865005ff5788410314f44f6de971a872cb4a0c4ebcf8707664f4732::shily {
    struct SHILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHILY>(arg0, 6, b"SHILY", b"Shily", b"Cute shark on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052664_f84c368126.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

