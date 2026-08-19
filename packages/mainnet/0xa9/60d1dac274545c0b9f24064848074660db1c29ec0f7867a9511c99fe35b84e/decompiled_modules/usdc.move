module 0xa960d1dac274545c0b9f24064848074660db1c29ec0f7867a9511c99fe35b84e::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::upgrade_service::new<USDC>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDC>(v1, 6, b"MUSDC", b"My USDC", b"My regulated stablecoin token deployed with Circle USDC contract pattern.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://example.com/musdc.png"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
        0x2::transfer::public_share_object<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<USDC>>(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::new<USDC>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::upgrade_service::UpgradeService<USDC>>(v0);
    }

    // decompiled from Move bytecode v7
}

