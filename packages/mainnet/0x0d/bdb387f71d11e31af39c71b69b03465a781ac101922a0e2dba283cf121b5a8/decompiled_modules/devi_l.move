module 0xdbdb387f71d11e31af39c71b69b03465a781ac101922a0e2dba283cf121b5a8::devi_l {
    struct DEVI_L has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVI_L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVI_L>(arg0, 6, b"DEVI_L", b"DAVIDsCHAITAN", b"is it the Devil? NO, OMG its DAVID, way worse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752829157622.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVI_L>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVI_L>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

