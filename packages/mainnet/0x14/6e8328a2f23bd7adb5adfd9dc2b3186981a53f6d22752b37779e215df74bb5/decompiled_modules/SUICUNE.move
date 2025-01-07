module 0x146e8328a2f23bd7adb5adfd9dc2b3186981a53f6d22752b37779e215df74bb5::SUICUNE {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 6, b"SUICUNE", b"Suicune", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

