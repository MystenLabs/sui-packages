module 0x628e1c73e606e9d56dfd8cd94a7dcfe31b0b66bc7142eaae13b0c3fb95d83435::xbtc {
    struct XBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBTC>(arg0, 6, b"XBTC", b"xBitcoin", x"58425443204a555354204c414e444544204f4e20535549200a5468652072756d6f7273207765726520747275652e2054686520616c70686120697320686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibtmv2faeuinwl6otf2caxk2crm2drv4en76mkqurmqqxzlsmqhvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

