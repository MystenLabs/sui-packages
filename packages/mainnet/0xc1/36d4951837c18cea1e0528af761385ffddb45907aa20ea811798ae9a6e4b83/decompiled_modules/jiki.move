module 0xc136d4951837c18cea1e0528af761385ffddb45907aa20ea811798ae9a6e4b83::jiki {
    struct JIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIKI>(arg0, 6, b"JIKI", b"JIKI The Monke", b"Hi my name is Jiki.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieo4pwet3cnh7ivjg2qx3rvgwiw23uy77sabrsp3hu44g4wjxpfp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

