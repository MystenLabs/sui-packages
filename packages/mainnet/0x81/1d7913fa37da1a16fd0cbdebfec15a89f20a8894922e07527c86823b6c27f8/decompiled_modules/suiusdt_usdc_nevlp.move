module 0x811d7913fa37da1a16fd0cbdebfec15a89f20a8894922e07527c86823b6c27f8::suiusdt_usdc_nevlp {
    struct SUIUSDT_USDC_NEVLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUSDT_USDC_NEVLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUSDT_USDC_NEVLP>(arg0, 9, b"nevLP-suiUSDT-USDC", b"nevLP-suiUSDT-USDC", b"nevLP-suiUSDT-USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtSuiUsdtUsdc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIUSDT_USDC_NEVLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUSDT_USDC_NEVLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

