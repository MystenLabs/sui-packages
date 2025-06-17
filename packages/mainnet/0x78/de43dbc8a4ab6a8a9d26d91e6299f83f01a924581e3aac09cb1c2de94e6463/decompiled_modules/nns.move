module 0x78de43dbc8a4ab6a8a9d26d91e6299f83f01a924581e3aac09cb1c2de94e6463::nns {
    struct NNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNS>(arg0, 6, b"NNS", b"New Noble SUI", b"New Noble SUI is a revolutionary new product with the same extraordinary potential as the SUI network, has made a stunning debut. Sourced from a rare and pristine water source, it undergoes purification through cutting-edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750122142260.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

