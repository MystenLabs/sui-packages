module 0xee7b880dfc55fb8a4b8f0ddd4438b74dee35f33829df93471a14dab32efe8232::suzu {
    struct SUZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZU>(arg0, 6, b"SUZU", b"Suzu", x"496e7374616772616d2073746172202453757a7520707574732074686520737520696e202453756920616e64206973207468652063757465737420646f67206f6e20636861696e0a0a54686520536869626120646f67206f66205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0498_8e7bab8601.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

