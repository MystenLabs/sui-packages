module 0xaf9a20697ce2f12e214770abdc894ced7799f842565f185a3e94113f293ebcfe::TCoin {
    struct TCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCOIN>(arg0, 6, b"TCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

