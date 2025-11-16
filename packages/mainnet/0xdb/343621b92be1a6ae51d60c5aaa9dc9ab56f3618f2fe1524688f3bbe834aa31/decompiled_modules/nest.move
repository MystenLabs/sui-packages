module 0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest {
    struct NEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEST>(arg0, 6, b"NEST", b"The NEST Token", b"Native token of SuiNest ecosystem", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

