module 0xf1c6f24de3d821375b7c216030a960008d256deadeb6bbb00eb5ea084005f5e4::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"Suiren", b"suiren is a sui-blue circular creature with a large mouth, capable of breathing fire, and two eyes shaped like himself. sent here to teach humanity how to cook.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731528249929.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

