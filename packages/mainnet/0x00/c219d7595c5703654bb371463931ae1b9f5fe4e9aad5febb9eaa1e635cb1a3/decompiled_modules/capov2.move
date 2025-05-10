module 0xc219d7595c5703654bb371463931ae1b9f5fe4e9aad5febb9eaa1e635cb1a3::capov2 {
    struct CAPOV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOV2>(arg0, 6, b"CAPOV2", b"Capo on Sui", b"I m gonna make him an offer he cant refuse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid2mmnryk7qz2rrqsltufhem4yiqmxl2ddgyqh6u6ui2x5l4r2ula")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPOV2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

