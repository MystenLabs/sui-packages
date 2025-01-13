module 0xa535b8915000e5a5f7f08fcd833bc816f7bdd4187ee0f647ea501df6caf82045::mind {
    struct MIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIND>(arg0, 9, b"MIND", b"Mind AI", b"Empowering the future with autonomous AI agents. Create, deploy, and scale adaptive solutions for any task, anywhere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR7frW7V57q7uMkkF5DThBW1XuS83qBCZcmvZsoFZ22x3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIND>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIND>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

