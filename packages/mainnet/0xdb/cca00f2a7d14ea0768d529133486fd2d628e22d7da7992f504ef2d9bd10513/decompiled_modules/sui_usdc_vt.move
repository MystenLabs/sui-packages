module 0xdbcca00f2a7d14ea0768d529133486fd2d628e22d7da7992f504ef2d9bd10513::sui_usdc_vt {
    struct SUI_USDC_VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_USDC_VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_USDC_VT>(arg0, 9, b"sui-usdc", b"sui-usdc", b"mmt sui-usdc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtXsuiSui.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_USDC_VT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_USDC_VT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

