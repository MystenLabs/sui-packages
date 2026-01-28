module 0x5352c1c20ba067cae243ba7528a594f78257be71ca96967100bf995809a3b602::usdjpy {
    struct USDJPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDJPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDJPY>(arg0, 9, b"USDJPY", b"USDJPY", b"ZO Virtual Coin for USDJPY (USD/JPY)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDJPY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDJPY>>(v0);
    }

    // decompiled from Move bytecode v6
}

