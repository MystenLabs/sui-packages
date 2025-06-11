module 0x3f74ebda70d5210011e1a006e6bd972389445df735d3d04303edf0988b5f5882::sfun {
    struct SFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFUN>(arg0, 6, b"SFUN", b"SuiFun", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaoxzzpuuzztchpfkbduy3it457xpgu65jgsf3j4obcn2kbradzea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

