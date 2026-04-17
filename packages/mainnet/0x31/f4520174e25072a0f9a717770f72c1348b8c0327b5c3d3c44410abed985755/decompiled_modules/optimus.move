module 0x31f4520174e25072a0f9a717770f72c1348b8c0327b5c3d3c44410abed985755::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIMUS>(arg0, 6, b"OPTIMUS", b"OPTIMUS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OPTIMUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

