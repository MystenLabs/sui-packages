module 0x20dfbb342d493c899c0033704d10a46b835b53ab8f501adb13f02098da3d6d9::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 9, b"DRIP", b"Drip", b"The liquid staking token for Deepbook AMM", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

