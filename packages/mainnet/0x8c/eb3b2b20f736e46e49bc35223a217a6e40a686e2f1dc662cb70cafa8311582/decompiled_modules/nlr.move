module 0x8ceb3b2b20f736e46e49bc35223a217a6e40a686e2f1dc662cb70cafa8311582::nlr {
    struct NLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLR>(arg0, 9, b"NLR", b"Vaneck Uranium & Nuclear ETF", b"ZO Virtual Coin for NLR (Vaneck Uranium & Nuclear ETF)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NLR>>(v0);
    }

    // decompiled from Move bytecode v6
}

