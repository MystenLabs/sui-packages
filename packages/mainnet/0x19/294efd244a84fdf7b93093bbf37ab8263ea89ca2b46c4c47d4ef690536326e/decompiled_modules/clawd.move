module 0x19294efd244a84fdf7b93093bbf37ab8263ea89ca2b46c4c47d4ef690536326e::clawd {
    struct CLAWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWD>(arg0, 6, b"CLAWD", b"ClawdCoin", b"Omnichain token deployed via LayerZero V2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

