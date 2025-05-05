module 0x7d60dbff7e82357760bcb43a4e0fe3eabd3c1574d29a69dabdbcdc1290548915::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 6, b"BB", b"Balraj", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaig4hzld75wt5gkwepj7bvn72lesdged3a4atpbzdrgzxt22ajbq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

