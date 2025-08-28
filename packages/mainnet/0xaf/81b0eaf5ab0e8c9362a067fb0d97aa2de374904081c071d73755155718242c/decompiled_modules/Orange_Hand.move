module 0xaf81b0eaf5ab0e8c9362a067fb0d97aa2de374904081c071d73755155718242c::Orange_Hand {
    struct ORANGE_HAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE_HAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE_HAND>(arg0, 9, b"ORANGE", b"Orange Hand", b"orange hodl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gy0Wz3fXEAEN0Db?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORANGE_HAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE_HAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

