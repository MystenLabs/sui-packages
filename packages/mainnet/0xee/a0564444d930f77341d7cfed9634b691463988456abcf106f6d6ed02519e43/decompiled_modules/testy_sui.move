module 0xeea0564444d930f77341d7cfed9634b691463988456abcf106f6d6ed02519e43::testy_sui {
    struct TESTY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTY_SUI>(arg0, 9, b"testySUI", b"Test Staked SUI", b"this is a test LST ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-ext-1.discordapp.net/external/trc661s04pNFpB_69-vTgIJdkCT2Q52to0p8mbdoUtY/https/suilend-assets.s3.us-east-2.amazonaws.com/rootSUI.png?format=webp&quality=lossless&width=1853&height=1853")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTY_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

