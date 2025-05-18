module 0x52b868c9503ab181925f5598d549b8759abf66b65354d87eafee9192c4ee7dad::muscle {
    struct MUSCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSCLE>(arg0, 6, b"MUSCLE", b"MUSCLE SUI", b"MUSCLE  A sexy big guy who can lift the chart with one hand", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeienyujk5s2hpd4rruewtewfqdyjusxf57pbyxszaewa7njf2izgzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUSCLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

