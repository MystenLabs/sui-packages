module 0x8a9a4d4d6f7071e8e7b6bcadc8e480797680c635e969bd0ac3228706152f58b7::shine {
    struct SHINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINE>(arg0, 6, b"SHINE", b"SHINE", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

