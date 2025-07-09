module 0x6a6a6e2ebe3d6240c398358dccb250739ea66d1dd7b6694c6996c28743f4949::tur {
    struct TUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUR>(arg0, 6, b"TUR", b"TURTLOS SUI", b"Im just turtlos, don't hope you can win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuacjlkqteq2xw5mbss3ozw6f7h7m4qg7tdj635q4vvougmbekym")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

