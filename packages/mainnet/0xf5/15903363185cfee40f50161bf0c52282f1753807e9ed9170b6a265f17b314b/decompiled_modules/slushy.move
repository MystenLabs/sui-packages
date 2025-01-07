module 0xf515903363185cfee40f50161bf0c52282f1753807e9ed9170b6a265f17b314b::slushy {
    struct SLUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUSHY>(arg0, 6, b"SLUSHY", b"Slushy's", x"536c7573687927732069732061206d656d6520636f696e206f6e2074686520537569204e6574776f726b2c206d616b696e6720776176657320696e207468652063727970746f20776f726c64210a4a6f696e206f75722066756e2c20636f6d6d756e6974792d64726976656e20616476656e747572652061732077652073706c617368206f75722077617920746f2074686520746f702e204c657427732063726561746520736f6d6520726970706c657320616e6420656e6a6f7920746865207269646520746f6765746865722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5p_B6_Upe_N_400x400_c437a7d69d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUSHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

