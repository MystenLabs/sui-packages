module 0x2033a217a2feefee360b02dc82bd2c8561359d9720cf361568c1d1b0ac813216::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"BLUDOGE", b"BLUDOGE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuzeg57rl53yuxzwkaclvgpkl5ecqufuhiqkwt2ht2z4z6dpaiee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

