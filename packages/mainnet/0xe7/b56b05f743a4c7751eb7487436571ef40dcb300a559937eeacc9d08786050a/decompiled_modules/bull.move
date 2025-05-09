module 0xe7b56b05f743a4c7751eb7487436571ef40dcb300a559937eeacc9d08786050a::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"BULL BOYZ", b"Bull Boyz. Relaunch bored bouz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreial523se5jxdsenadtd3zoddgfeguyh7a75ymmm2sh4rltcvsupcy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

