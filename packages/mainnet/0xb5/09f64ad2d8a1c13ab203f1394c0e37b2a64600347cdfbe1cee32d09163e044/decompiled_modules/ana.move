module 0xb509f64ad2d8a1c13ab203f1394c0e37b2a64600347cdfbe1cee32d09163e044::ana {
    struct ANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANA>(arg0, 6, b"ANA", b"Ana de Armas", x"0a596f752063616e2073686f776361736520416e612773206361707469766174696e6720656e6572677920616e6420796f7572206c6f766520666f72206865722066616e62617365206f6e2074686520626c6f636b636861696e2e2024414e412061696d7320746f2070726f7669646520616e20756e666f726765747461626c6520657870657269656e636520666f722065766572796f6e652077686f206a6f696e732074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_Mz_XHT_Xk_AA_Jbi_W_ddd03bbd11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

