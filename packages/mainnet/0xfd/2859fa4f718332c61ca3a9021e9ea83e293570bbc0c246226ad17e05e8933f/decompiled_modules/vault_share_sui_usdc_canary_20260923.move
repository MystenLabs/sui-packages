module 0xfd2859fa4f718332c61ca3a9021e9ea83e293570bbc0c246226ad17e05e8933f::vault_share_sui_usdc_canary_20260923 {
    struct VAULT_SHARE_SUI_USDC_CANARY_20260923 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAULT_SHARE_SUI_USDC_CANARY_20260923, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT_SHARE_SUI_USDC_CANARY_20260923>(arg0, 9, b"AVSUSDC", b"Alpha SUI USDC Canary Share", b"Share coin for one Alpha DLMM vault", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT_SHARE_SUI_USDC_CANARY_20260923>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAULT_SHARE_SUI_USDC_CANARY_20260923>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

