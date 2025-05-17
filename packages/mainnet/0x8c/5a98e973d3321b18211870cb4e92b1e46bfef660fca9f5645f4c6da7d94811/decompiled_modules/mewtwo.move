module 0x8c5a98e973d3321b18211870cb4e92b1e46bfef660fca9f5645f4c6da7d94811::mewtwo {
    struct MEWTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWTWO>(arg0, 6, b"MEWTWO", x"74686520776f726c642773207374726f6e6765737420506f6bc3a96d6f6e2e", b"Just hold $MEWTWO and enjoy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacfsnduqpyumu4a3ndqsyidvqfh2qko6qmcir2ts4cpufd3kg5fa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWTWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEWTWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

