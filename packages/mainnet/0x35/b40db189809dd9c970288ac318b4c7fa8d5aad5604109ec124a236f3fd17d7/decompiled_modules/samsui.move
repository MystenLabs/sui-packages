module 0x35b40db189809dd9c970288ac318b4c7fa8d5aad5604109ec124a236f3fd17d7::samsui {
    struct SAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAMSUI>(arg0, 9, 0x1::string::utf8(b"samsui"), 0x1::string::utf8(b"Sam SUI"), 0x1::string::utf8(b"Sam SUI"), 0x1::string::utf8(b"https://usesam.xyz/tokens/samsui.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAMSUI>>(0x2::coin_registry::finalize<SAMSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

