module 0x8a48e0efa9d6020f76f1fcb5661a32889a90f0d74be28ab20655cfb2c41c746a::puddy {
    struct PUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDY>(arg0, 6, b"PUDDY", b"YUMMY PUDDY", b"DESSERT IS SERVED, WOBBLE AND GOBBLE $PUDDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieuw3gqm56auqbrnfsls7bqsn6t2s3j5dm2rcsvdjjvjdtowhg3qq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUDDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

