module 0xcb980386ac5f9bd16baa63b319f9fbeabd8eef1c6214df0d161347a9786a5d7d::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBO>(arg0, 6, b"SUIBO", b"SUIBO on SUI", b"SUIBO is ticker!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwxon6bxv6pej4irnwhizpmqp4vpbjroximpyq4gk2bwq7eiu454")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

