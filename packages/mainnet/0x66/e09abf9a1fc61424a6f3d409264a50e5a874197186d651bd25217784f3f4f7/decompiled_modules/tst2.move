module 0x66e09abf9a1fc61424a6f3d409264a50e5a874197186d651bd25217784f3f4f7::tst2 {
    struct TST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST2>(arg0, 6, b"TST2", b"TST V2", b"Test, do not buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiekxjgjbtx2jwa4ilyfisoxuccp5rgurcebi2c5r2mzztxf2e2ezm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

