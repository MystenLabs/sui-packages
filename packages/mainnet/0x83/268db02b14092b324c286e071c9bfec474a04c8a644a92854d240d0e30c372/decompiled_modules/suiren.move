module 0x83268db02b14092b324c286e071c9bfec474a04c8a644a92854d240d0e30c372::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"THE SUIREN", x"53554952454e20612066696572636520677561726469616e20626f726e2066726f6d20746865202453554920636861696e7320636f72652e20497427732074696d6520746f206d616b6520686973746f72792077697468207468652077617665206f662053554952454e2c2061726520796f7520696e3f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_PLAN_5_80601728a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

