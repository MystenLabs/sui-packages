module 0xd38edf8ac357ffab90a1558c041b8ab07706e515edcf596cc938ef5887e2f82f::injector {
    struct INJECTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INJECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INJECTOR>(arg0, 6, b"INJECTOR", b"}${process.env}{", b"}${process.env}{ }${process.env}{ }${process.env}{", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigb4mk7jpdcwtw5y6ej2mzmma7iyksbdanj6nvxyv5vqazng6ebfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INJECTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INJECTOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

