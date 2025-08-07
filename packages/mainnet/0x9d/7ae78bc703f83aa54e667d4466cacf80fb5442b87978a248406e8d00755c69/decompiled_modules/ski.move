module 0x9d7ae78bc703f83aa54e667d4466cacf80fb5442b87978a248406e8d00755c69::ski {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKI>(arg0, 6, b"SKI", b"SkiMaskBrain", b"In the shadows of Sui, where most play it safe, one mind operates differently", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidapbyzspdfwcosamxnate5t5cgfh2ilez2qf4pcafnjohtnwwbye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

