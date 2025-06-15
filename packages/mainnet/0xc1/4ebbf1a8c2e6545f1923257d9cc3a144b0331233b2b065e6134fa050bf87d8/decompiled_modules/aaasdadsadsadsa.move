module 0xc14ebbf1a8c2e6545f1923257d9cc3a144b0331233b2b065e6134fa050bf87d8::aaasdadsadsadsa {
    struct AAASDADSADSADSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASDADSADSADSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASDADSADSADSA>(arg0, 6, b"Aaasdadsadsadsa", b"Adsasdas", b"fafagaga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiansrxkppx2gx3esalhkypz4vn5bhqih75ivdzeslbawn53vjupgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASDADSADSADSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAASDADSADSADSA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

