module 0xb477a0a2f9079d80526c3b69c7496e41e724e03d15d7e020590307ac06c49774::mordecai {
    struct MORDECAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORDECAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORDECAI>(arg0, 6, b"MORDECAI", b"Mordecai on Sui", x"4d65657420244d4f5244454341492c20546865206c616964206261636b20626c7565206a61792066726f6d20796f7572206661766f726974652073686f7720686173206c616e646564206f6e20537569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Morde_PP_92c25f96aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORDECAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORDECAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

