module 0x25fb6555226542981e9d07fe651fef2d06a3bf36684e2a8ef462715a441a2763::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 6, b"Sky", b"Skinny ", b"Remember to get out of the trenches from time to time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737935782679.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

