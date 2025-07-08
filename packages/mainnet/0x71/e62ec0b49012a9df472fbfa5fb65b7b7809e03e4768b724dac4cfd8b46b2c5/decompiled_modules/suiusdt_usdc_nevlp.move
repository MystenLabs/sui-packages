module 0x71e62ec0b49012a9df472fbfa5fb65b7b7809e03e4768b724dac4cfd8b46b2c5::suiusdt_usdc_nevlp {
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

