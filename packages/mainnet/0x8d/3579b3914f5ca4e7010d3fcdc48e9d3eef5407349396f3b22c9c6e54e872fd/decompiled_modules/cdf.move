module 0x8d3579b3914f5ca4e7010d3fcdc48e9d3eef5407349396f3b22c9c6e54e872fd::cdf {
    struct CDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDF>(arg0, 6, b"CDF", b"sdfgerdfg", b"asdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

