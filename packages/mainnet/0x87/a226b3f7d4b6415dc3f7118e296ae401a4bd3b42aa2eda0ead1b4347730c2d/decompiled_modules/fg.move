module 0x87a226b3f7d4b6415dc3f7118e296ae401a4bd3b42aa2eda0ead1b4347730c2d::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 6, b"FG", b"frog", b"FROG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1785289378931.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

