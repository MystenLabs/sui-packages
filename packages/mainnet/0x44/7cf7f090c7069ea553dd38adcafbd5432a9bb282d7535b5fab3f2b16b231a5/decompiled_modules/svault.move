module 0x447cf7f090c7069ea553dd38adcafbd5432a9bb282d7535b5fab3f2b16b231a5::svault {
    struct SVAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVAULT>(arg0, 6, b"SVault", b"SuiVault", b"SuiVault is a meme token built on the Sui blockchain, combining the fun of meme culture with the security of a digital vault. Designed to provide both entertainment and long-term value, SuiVault offers a safe and rewarding experience for investors who want to be part of the next big trend in crypto while preserving their assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/32_CFD_2_DA_5_C09_46_DD_A688_8_C04_D2_EFD_5_FE_66580176c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVAULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVAULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

