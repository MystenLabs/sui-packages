module 0x33dc8ad8a39749799e0dc4ff22a84378cb96e55526fa30c0506557bbaefe1153::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"FISHERMAN", b"A chill fisherman", b"A fisherman with an ambition of catching whales", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735499459416.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

