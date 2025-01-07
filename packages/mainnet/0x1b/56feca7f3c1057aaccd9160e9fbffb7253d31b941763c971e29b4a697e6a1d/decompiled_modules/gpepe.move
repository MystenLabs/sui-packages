module 0x1b56feca7f3c1057aaccd9160e9fbffb7253d31b941763c971e29b4a697e6a1d::gpepe {
    struct GPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPEPE>(arg0, 6, b"GPEPE", b"Grumpy Pepe On Sui", b"Pepes Grumpy Because $Sui Hasnt Hit $100 Yet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_BC_344_ED_E645_4_B13_963_E_F9_E2_CF_6014_E5_be3da5c297.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

