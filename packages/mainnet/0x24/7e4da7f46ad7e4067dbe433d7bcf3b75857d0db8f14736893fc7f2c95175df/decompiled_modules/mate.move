module 0x247e4da7f46ad7e4067dbe433d7bcf3b75857d0db8f14736893fc7f2c95175df::mate {
    struct MATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATE>(arg0, 6, b"Mate", b"Halo Mate", b"hihi haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaanx6zk2ms53kiwrrwyy2re53zjz46rwlwuv2pyc5bmewx4p5fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

