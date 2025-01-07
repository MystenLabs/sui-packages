module 0xc5d42eda9e36e24282f655cebf25f340e1bd43c2a6ee80998ce0ea4cd4306401::shhs {
    struct SHHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHHS>(arg0, 6, b"SHHS", b"SUIHAMMERHEAD", b"The coolest shark on sui ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2c8b393851d3af1c0170d388cb2a5f94_d66525947c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

