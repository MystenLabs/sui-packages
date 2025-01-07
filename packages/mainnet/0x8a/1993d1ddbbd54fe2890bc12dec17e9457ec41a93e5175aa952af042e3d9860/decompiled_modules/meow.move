module 0x8a1993d1ddbbd54fe2890bc12dec17e9457ec41a93e5175aa952af042e3d9860::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"SUIMEOW", b"just a meow on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEOW_f293e4f3c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

