module 0xe7c16ca5face261c8990492fb205d7d58cf761c368c14840703f527d32f087ae::flui {
    struct FLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUI>(arg0, 6, b"Flui", b"Fluid Sui", b"Fluid SUI is an innovative cryptocurrency token designed to empower users with a decentralized swap exchange, integrating NFTs and DeFi features. The platform allows users to seamlessly trade tokens, providing efficient and secure exchanges without intermediaries. With the inclusion of NFTs, Fluid SUI offers unique digital assets, collectibles, and ownership opportunities. The DeFi aspect allows users to engage in staking, yield farming, and liquidity provision, further enhancing the value of their holdings. Fluid SUIs goal is to create an accessible, user-friendly platform that combines cutting-edge technology with community-driven finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_18_16_14_58_A_modern_logo_for_a_token_named_Flui_built_on_the_Sui_network_The_logo_should_feature_sleek_rounded_sans_serif_font_for_the_word_Flui_to_give_it_e969ccc249.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

