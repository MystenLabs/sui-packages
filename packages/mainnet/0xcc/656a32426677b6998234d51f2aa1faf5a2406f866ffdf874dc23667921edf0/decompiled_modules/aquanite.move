module 0xcc656a32426677b6998234d51f2aa1faf5a2406f866ffdf874dc23667921edf0::aquanite {
    struct AQUANITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUANITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUANITE>(arg0, 6, b"AQUANITE", b"aquanite sui", b"tiny project artwork seek pretty hidden art casual shuffle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3qrln2tbxahm4mlh5dfjfdcshkccp5m7lhzqrfo6iwbekp6pzyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUANITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUANITE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

