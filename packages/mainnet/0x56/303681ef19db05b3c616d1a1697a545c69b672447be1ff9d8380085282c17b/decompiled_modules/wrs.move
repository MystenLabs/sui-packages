module 0x56303681ef19db05b3c616d1a1697a545c69b672447be1ff9d8380085282c17b::wrs {
    struct WRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRS>(arg0, 6, b"WRS", b"Walrus", b"TEsting testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidnp56qwjthv4ryljbqy5yda4ccod5u4fy43wwtjqu5f2uxp2ns34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WRS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

