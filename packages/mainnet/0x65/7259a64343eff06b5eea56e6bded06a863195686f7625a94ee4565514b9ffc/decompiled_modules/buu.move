module 0x657259a64343eff06b5eea56e6bded06a863195686f7625a94ee4565514b9ffc::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUU>(arg0, 6, b"Buu", b"Suipirit Buu", b"Buu aims to build a fun, strong, and creative community within the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifcuhxuajrbrj6jol5xwcpag3wcasqb4gyjbxromiha3hqp75qumm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

