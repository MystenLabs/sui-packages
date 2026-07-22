module 0xcf857a2d34dc8a740de7806735caa598c55057a12ec4692ef3564c57bdadd9a8::fake_sui_v2 {
    struct FAKE_SUI_V2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_SUI_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_SUI_V2>(arg0, 9, b"SUI", b"Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_SUI_V2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI_V2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

