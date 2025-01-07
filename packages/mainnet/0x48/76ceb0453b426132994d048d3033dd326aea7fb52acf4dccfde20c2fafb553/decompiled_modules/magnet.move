module 0x4876ceb0453b426132994d048d3033dd326aea7fb52acf4dccfde20c2fafb553::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"MAGNET", b"Magnet on Sui", x"74686520206d65616e7320736f6d657468696e67206974206d65616e7320686f7065206974206d65616e732062656c6965766520696e20736f6d657468696e6720697473206f757220776f726c642c2065766572796f6e6520656c7365206973206a757374206c6976696e6720696e2069740a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8i_Ws_K2_WH_3_A_Gvi_Qw_Ant43zvc8y_Ly6_QMU_Suv8_PK_2_A7pump_3dae1420d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

