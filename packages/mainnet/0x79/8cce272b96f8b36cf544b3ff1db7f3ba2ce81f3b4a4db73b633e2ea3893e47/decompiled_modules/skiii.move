module 0x798cce272b96f8b36cf544b3ff1db7f3ba2ce81f3b4a4db73b633e2ea3893e47::skiii {
    struct SKIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIII>(arg0, 6, b"SKIII", b"SKCoin3", b"this is test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/socialkingdom_d1788c9c10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

