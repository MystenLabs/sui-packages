module 0xf38cfd0374810813a18298f41bf9a58f8c2d0080197a877416264cb44b14e35::scammer {
    struct SCAMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMMER>(arg0, 6, b"SCAMMER", b"SCAMMER", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCAMMER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

