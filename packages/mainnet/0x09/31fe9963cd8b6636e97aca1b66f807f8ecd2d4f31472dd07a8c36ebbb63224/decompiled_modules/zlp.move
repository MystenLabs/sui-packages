module 0x931fe9963cd8b6636e97aca1b66f807f8ecd2d4f31472dd07a8c36ebbb63224::zlp {
    struct ZLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZLP>(arg0, 6, b"syZLP", b"SY ZLP", b"SY ZO Perpetuals LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

