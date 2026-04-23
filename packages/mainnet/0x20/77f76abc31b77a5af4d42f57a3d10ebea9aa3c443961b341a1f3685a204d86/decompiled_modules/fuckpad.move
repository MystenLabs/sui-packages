module 0x2077f76abc31b77a5af4d42f57a3d10ebea9aa3c443961b341a1f3685a204d86::fuckpad {
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

