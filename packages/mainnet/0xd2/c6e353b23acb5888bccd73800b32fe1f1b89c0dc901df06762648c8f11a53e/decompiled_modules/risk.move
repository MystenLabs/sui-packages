module 0xd2c6e353b23acb5888bccd73800b32fe1f1b89c0dc901df06762648c8f11a53e::risk {
    struct RISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISK>(arg0, 6, b"RISK", b"RICH", b"who knows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/78662be105a01bb922f6489b4cd7f147_36e75fb90c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISK>>(v1);
    }

    // decompiled from Move bytecode v6
}

