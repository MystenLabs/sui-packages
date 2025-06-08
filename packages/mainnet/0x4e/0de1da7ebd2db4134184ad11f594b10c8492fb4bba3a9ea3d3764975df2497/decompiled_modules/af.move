module 0x4e0de1da7ebd2db4134184ad11f594b10c8492fb4bba3a9ea3d3764975df2497::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 6, b"AF", b"DFA", b"SDFA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifkhjsvl327v4pha4ko2yvhlx5gbxuik2iw5m6ypxfagnleq7al64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

