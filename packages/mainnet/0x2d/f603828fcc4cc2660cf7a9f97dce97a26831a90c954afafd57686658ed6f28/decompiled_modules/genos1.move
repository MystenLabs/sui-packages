module 0x2df603828fcc4cc2660cf7a9f97dce97a26831a90c954afafd57686658ed6f28::genos1 {
    struct GENOS1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENOS1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENOS1>(arg0, 6, b"GENOS1", b"GENOS1", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENOS1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENOS1>>(v1);
    }

    // decompiled from Move bytecode v6
}

