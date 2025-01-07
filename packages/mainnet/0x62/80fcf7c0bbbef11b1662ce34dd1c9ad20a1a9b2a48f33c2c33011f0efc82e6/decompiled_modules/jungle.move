module 0x6280fcf7c0bbbef11b1662ce34dd1c9ad20a1a9b2a48f33c2c33011f0efc82e6::jungle {
    struct JUNGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNGLE>(arg0, 6, b"JUNGLE", b"JUNGLExSui", b"Kong embodies the spirit of innovation and the relentless pursuit of financial freedom that drives the cryptocurrency community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735959717433.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNGLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNGLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

