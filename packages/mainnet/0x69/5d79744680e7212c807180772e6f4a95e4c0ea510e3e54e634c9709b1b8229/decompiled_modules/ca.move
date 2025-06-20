module 0x695d79744680e7212c807180772e6f4a95e4c0ea510e3e54e634c9709b1b8229::ca {
    struct CA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CA>(arg0, 6, b"CA", b"CATA", b"CAB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichtvjemx6iazqrune7tx3mirxmzyf34klbtefpye27xe5w2ioky4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

