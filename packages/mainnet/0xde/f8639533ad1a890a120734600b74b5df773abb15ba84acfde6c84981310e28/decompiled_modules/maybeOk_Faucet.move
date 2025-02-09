module 0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk_Faucet {
    struct MAYBEOK_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYBEOK_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYBEOK_FAUCET>(arg0, 8, b"MAYBEOK_FAUCET", b"MAYBEOK_FAUCET", b"this is person MAYBEOK_FAUCET test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYBEOK_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MAYBEOK_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

