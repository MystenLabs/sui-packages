module 0x6a65a4dc09ae8028d08142faa8076835d766ece918244626acd45165dbbf9c05::usdcf {
    struct USDCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDCF>(arg0, 6, b"USDCF", b"USDC Faked", b"Faked USDC stablecoin for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDCF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDCF>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDCF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDCF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

