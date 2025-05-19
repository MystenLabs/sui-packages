module 0x453c3a940c547204aed0c9fadc641457b0d13a4ee5c7b7132be7ffa62ffd1ecf::aquanite {
    struct AQUANITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUANITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUANITE>(arg0, 6, b"AQUANITE", b"AQUANITE SUI", b"The dragonite of $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3qrln2tbxahm4mlh5dfjfdcshkccp5m7lhzqrfo6iwbekp6pzyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUANITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUANITE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

