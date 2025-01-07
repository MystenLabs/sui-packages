module 0xda131b43b0df95327fdc2d6d302af8f6346841d56ffc115824e297dd51ce0b34::caesar {
    struct CAESAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAESAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAESAR>(arg0, 6, b"CAESAR", b"caesarape sui", b"Dexscreener Paid.Join us: https://caesarapesui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_22_76d545bb61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAESAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAESAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

