module 0x2e6c5b963c248ae765ccb34d517fec2cc82c3818178aff32bd636e2c8752c6f4::kamisayaka_faucet {
    struct KAMISAYAKA_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMISAYAKA_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMISAYAKA_FAUCET>(arg0, 8, b"KAMISAYAKA_FAUCET", b"kamisayaka_faucet", b"my first move faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/54GNKMSAurz1vbH77")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMISAYAKA_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<KAMISAYAKA_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

