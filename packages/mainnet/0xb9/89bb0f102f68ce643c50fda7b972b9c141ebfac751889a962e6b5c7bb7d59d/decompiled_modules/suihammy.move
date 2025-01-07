module 0xb989bb0f102f68ce643c50fda7b972b9c141ebfac751889a962e6b5c7bb7d59d::suihammy {
    struct SUIHAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHAMMY>(arg0, 6, b"SUIHAMMY", b"SUI HAMSTER ( SAD )", b"IT IS VERY SAD :(", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_749b3cdf89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

