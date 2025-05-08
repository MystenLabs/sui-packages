module 0xe59d0dd61d76996a878ddbbb61de8475485215e84f3d1827917b12bfeab30471::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"Swog", b"Swog relaunch CTO", b"Relaunch swog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifxsa2oasg3le6zd76c5qdnzgwqwd6oe6hoponoma2rqiknlb2nny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

