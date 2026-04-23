module 0x508abe5fb919bf276eab41eceada797dbb61d57254258ab26499d05e3990170f::guy {
    struct GUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUY>(arg0, 6, b"GUY", b"GUY", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

