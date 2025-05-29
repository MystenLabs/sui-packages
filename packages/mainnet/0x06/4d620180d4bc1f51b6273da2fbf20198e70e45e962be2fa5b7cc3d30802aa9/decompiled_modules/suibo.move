module 0x64d620180d4bc1f51b6273da2fbf20198e70e45e962be2fa5b7cc3d30802aa9::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBO>(arg0, 6, b"SUIBO", b"Suibo on SUI", b"Just a money game!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwxon6bxv6pej4irnwhizpmqp4vpbjroximpyq4gk2bwq7eiu454")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

