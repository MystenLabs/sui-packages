module 0x4547c425e4a473bd6fa9d84ef3542371fcbcd5ac0fdaaefdcf7b2c20f99da0fb::mug {
    struct MUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUG>(arg0, 6, b"MUG", b"SUI MUG", x"48492c20494d20244d5547210a0a57656c636f6d6520746f204d5547202d204d656d657320556e6465722047726f756e6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_05_10_44_66b08646a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

