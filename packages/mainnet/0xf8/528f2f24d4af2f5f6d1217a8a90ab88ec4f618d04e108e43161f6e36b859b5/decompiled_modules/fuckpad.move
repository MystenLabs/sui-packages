module 0xf8528f2f24d4af2f5f6d1217a8a90ab88ec4f618d04e108e43161f6e36b859b5::fuckpad {
    struct FUCKPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKPAD>(arg0, 6, b"FUCKPAD", b"FUCKPAD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKPAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

