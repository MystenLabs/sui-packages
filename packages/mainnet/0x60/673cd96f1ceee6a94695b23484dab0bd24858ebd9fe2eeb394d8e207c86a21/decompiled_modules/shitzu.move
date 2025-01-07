module 0x60673cd96f1ceee6a94695b23484dab0bd24858ebd9fe2eeb394d8e207c86a21::shitzu {
    struct SHITZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITZU>(arg0, 6, b"Shitzu", b"Shitsui", b"Shitsui is the first Shitzu on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731479796062.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHITZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

