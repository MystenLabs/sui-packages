module 0x6ba0ffe5a55faba4ae631f1b64144f31554d2e322f92c1ac6b4e0989f7ad6de6::hehea {
    struct HEHEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHEA>(arg0, 6, b"HEHEA", b"humm", b"Duaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaanx6zk2ms53kiwrrwyy2re53zjz46rwlwuv2pyc5bmewx4p5fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEHEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

