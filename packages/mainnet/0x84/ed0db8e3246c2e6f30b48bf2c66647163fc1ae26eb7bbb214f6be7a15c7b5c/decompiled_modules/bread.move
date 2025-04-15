module 0x84ed0db8e3246c2e6f30b48bf2c66647163fc1ae26eb7bbb214f6be7a15c7b5c::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"BREAD", b"JUST A BREAD", b"JUST A STANDING TIRED BREAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreidfeeaphrsyqgqyktqbtjbzawks76nbqf4ko44vsi2apwmu4ccthy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BREAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

