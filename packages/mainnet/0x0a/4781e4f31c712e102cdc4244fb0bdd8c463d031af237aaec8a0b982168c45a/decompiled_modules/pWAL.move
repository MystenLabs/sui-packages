module 0xa4781e4f31c712e102cdc4244fb0bdd8c463d031af237aaec8a0b982168c45a::pWAL {
    struct PWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWAL>(arg0, 9, b"sypWAL", b"SY pWAL", b"SY Patara Staked Walrus", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

