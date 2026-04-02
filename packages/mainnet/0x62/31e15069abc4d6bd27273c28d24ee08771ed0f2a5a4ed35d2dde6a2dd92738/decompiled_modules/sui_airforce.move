module 0x6231e15069abc4d6bd27273c28d24ee08771ed0f2a5a4ed35d2dde6a2dd92738::sui_airforce {
    struct SUI_AIRFORCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_AIRFORCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_AIRFORCE>(arg0, 6, b"SUI AIRFORCE", b"SUI Air Force", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_AIRFORCE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_AIRFORCE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_AIRFORCE>>(v2);
    }

    // decompiled from Move bytecode v6
}

