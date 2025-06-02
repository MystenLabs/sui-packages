module 0x1993747b42767361c9c2e56db74b2af8615a6ede478d0884c2504fd2b8caeb3e::spt {
    struct SPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPT>(arg0, 6, b"SPT", b"SUI POKEMOON TEAM", b"Pokemoon inspires fans worldwide to embark on epic adventures, capturing hearts with its vibrant creatures and timeless theme of friendship and perseverance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaddvs7xx7r6h4lnirfdsojvzvx2yegnyqgyptbussn6w77a44eg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

