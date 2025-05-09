module 0xa2bb8c2f6961ae8e6e692cb1542aae7afde93c8db838ee4fbc926d08335076c6::reevh {
    struct REEVH has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEVH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEVH>(arg0, 6, b"REEVH", b"test", b"FUCK JEEEEEEEEEEEEEEEEEEEEEETERSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaxu526f7pso3ydyr2wmiavhhcwcugsbb6asa6gd3yo2n3nkd2gxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEVH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REEVH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

