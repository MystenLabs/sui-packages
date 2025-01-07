module 0xcfd9d18060a9f529430c113a51b577648e7f864f9f3e8b32cc9d6b22cb527690::sepe {
    struct SEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEPE>(arg0, 6, b"SEPE", b"SuiPepe", b"Pepe Ate Too Many Blieberries", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/546_B3_EA_8_8_A2_B_40_B7_82_F4_8_B8309_E7_E080_49e67f1637.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

