module 0x61199a9284ac06682bae0bd2a62d92fe27e9c4c9b310db9d360d3578562528a7::clung {
    struct CLUNG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLUNG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CLUNG>>(0x2::coin::mint<CLUNG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CLUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUNG>(arg0, 6, b"CLUNG", b"Clung McLuggin", b"For the boys", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

