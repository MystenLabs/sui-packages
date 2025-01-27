module 0xcd8f8a6fcd309e6d00f6f8f2d37eeeedeee7ccb50934d457e5a0a2f3e65bdbd2::ft_bluefin_stsui_sui {
    struct FT_BLUEFIN_STSUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FT_BLUEFIN_STSUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FT_BLUEFIN_STSUI_SUI>(arg0, 9, b"PAFT_BLUEFIN_STSUI_SUI", b"FT_BLUEFIN_STSUI_SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FT_BLUEFIN_STSUI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FT_BLUEFIN_STSUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

