module 0x5a9a17c9ff9c3dbf5a7b95d9d932a8e09661780f220f46a8cf477f3433b7b31e::slow {
    struct SLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOW>(arg0, 6, b"SLOW", b"Suillow", b"The elegant bird of SUI  fast, fearless, and flying to the top. Inspired by Swellow, the high flying Pokemon built for glory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwbamzxijog7z7lqkxpobtx226sx7ch7kcuz3olhmpdqym374w54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

