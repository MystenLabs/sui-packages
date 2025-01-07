module 0x4517f76fb0b2a105c930f240960e5b644cc263c6387b85f766367770292ad59b::stcoin {
    struct STCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STCOIN>(arg0, 6, b"STCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

