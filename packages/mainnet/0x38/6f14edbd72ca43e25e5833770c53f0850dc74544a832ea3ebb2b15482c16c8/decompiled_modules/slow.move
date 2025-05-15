module 0x386f14edbd72ca43e25e5833770c53f0850dc74544a832ea3ebb2b15482c16c8::slow {
    struct SLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOW>(arg0, 6, b"SLOW", b"Suillow", b"The elegant bird of SUI  fast, fearless, and flying to the top. Pokemon built for glory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwbamzxijog7z7lqkxpobtx226sx7ch7kcuz3olhmpdqym374w54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

