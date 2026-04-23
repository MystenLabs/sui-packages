module 0xa14f4f831a9367abddf60535a55517f05dfd378d97cf8d959afa6876082392d7::fackpad {
    struct FACKPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACKPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACKPAD>(arg0, 6, b"FACKPAD", b"FACKPAD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACKPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FACKPAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

