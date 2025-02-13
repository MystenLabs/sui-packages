module 0x39c6a59140eac0d542f6c22ffd03ba80c2847ae53abd369a17f59eb973e0a9c3::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"THE SUIREN", x"53554952454e20612066696572636520677561726469616e20626f726e2066726f6d20746865202453554920636861696e7320636f72652e200a497427732074696d6520746f206d616b6520686973746f72792077697468207468652077617665206f662053554952454e2c2061726520796f7520696e3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_PLAN_5_0fbd3f6280.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

