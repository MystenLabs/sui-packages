module 0xbea898c10cbdce78040ca666da2f598703a2f3cd8bbe56c416a22756583f8b30::sui_test {
    struct SUI_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TEST>(arg0, 6, b"SUI-TEST", b"Sui Test", b"Sui Test Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

