module 0x17f6cfe0eb1971d38e1996e3b3b7f1fc70b3ec19666c4f457aedf969d49da0cd::mellowa {
    struct MELLOWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELLOWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELLOWA>(arg0, 6, b"MELLOWA", b"MELLOWSUI", b"MELLOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spr1_d4cd964069.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELLOWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELLOWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

