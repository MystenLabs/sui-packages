module 0x54303dd036ff541cf1011f4d91a3a9c912fd83590e5b5cd54e066606bb9621c7::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIG", b"PigWifHat", b"Its just a piggy. But wif a hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/844_A39_AE_B7_A8_4_B62_96_D7_933_D8_D29_C987_6374e90171.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

