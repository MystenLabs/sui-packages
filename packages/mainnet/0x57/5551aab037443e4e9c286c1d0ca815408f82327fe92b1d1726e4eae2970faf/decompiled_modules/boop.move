module 0x575551aab037443e4e9c286c1d0ca815408f82327fe92b1d1726e4eae2970faf::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 6, b"Boop", b"JAV6789", b"just a fun coin, no one guesses it can be bad. Fun coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia46uatxu7yld5oeyge5zxryevmxjvdtnzgxmonbuui3hsbw4oxxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

