module 0xf10371b5265fc5ff9b4ff68247a7173f76273e6f085862c2bde244a8f9e94b5c::volume {
    struct VOLUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLUME>(arg0, 9, b"VOLUME", b"VOLUME COIN", x"416e6e6f756e63696e673a20426c61737420496e63656e74697665732031304b20555344432065766572792032207765656b7320f09f8f862047656e6572616c3a20312c303030205553444320f09f8e96efb88f204361707461696e3a20373530205553444320f09fa589204c69657574656e616e743a20363030205553444320f09faa9620536f6c6469657273202852616e6b73202334e280933230293a20343530205553444320656163682052616e6b7320617265206261736564206f6e20766f6c756d652c20626f747320776f6ee280997420737572766976652e207c20576562736974653a2068747470733a2f2f692e696d6775722e636f6d2f7a4c44327837452e6a706567", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/zLD2x7E.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOLUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

