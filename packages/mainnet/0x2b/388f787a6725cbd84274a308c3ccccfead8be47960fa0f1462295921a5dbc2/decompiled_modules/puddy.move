module 0x2b388f787a6725cbd84274a308c3ccccfead8be47960fa0f1462295921a5dbc2::puddy {
    struct PUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDY>(arg0, 6, b"PUDDY", b"YUMMY PUDDY", b"the ultimate wobble & gobble pudding cat! This chubby, jiggly, and irresistibly cute feline is here to shake up the crypto world one yummy bite at a time. Soft, sweet, and always hungry for gains, $PUDDY is the tastiest memecoin around. Join the feast!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieuw3gqm56auqbrnfsls7bqsn6t2s3j5dm2rcsvdjjvjdtowhg3qq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUDDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

