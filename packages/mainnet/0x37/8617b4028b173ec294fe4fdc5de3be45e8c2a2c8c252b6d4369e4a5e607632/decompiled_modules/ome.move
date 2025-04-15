module 0x378617b4028b173ec294fe4fdc5de3be45e8c2a2c8c252b6d4369e4a5e607632::ome {
    struct OME has drop {
        dummy_field: bool,
    }

    fun init(arg0: OME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OME>(arg0, 6, b"OME", b"Omelio", b"just Omelio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreifpdeuwdrhv27bvp7us6gr3mhhxi54sa3j535ucloxxfg7cryvzdu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

