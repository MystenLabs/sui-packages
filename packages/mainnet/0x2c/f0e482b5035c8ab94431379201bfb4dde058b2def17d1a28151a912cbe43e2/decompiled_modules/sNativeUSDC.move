module 0x632ae0f5031269e2192c0fc4e700edba8a014783ad00047ec4313c5c3d3062cd::sNativeUSDC {
    struct SNATIVEUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNATIVEUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNATIVEUSDC>(arg0, 9, b"sysNativeUSDC", b"SY sNativeUSDC", b"SY scallop sNativeUSDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNATIVEUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNATIVEUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

