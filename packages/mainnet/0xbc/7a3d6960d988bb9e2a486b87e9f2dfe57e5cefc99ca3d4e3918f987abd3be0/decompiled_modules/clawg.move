module 0xbc7a3d6960d988bb9e2a486b87e9f2dfe57e5cefc99ca3d4e3918f987abd3be0::clawg {
    struct CLAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWG>(arg0, 6, b"CLAWG", b"ClawdGold", b"Omnichain token deployed via LayerZero V2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

