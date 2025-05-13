module 0xc698c628fb42a4cd04263816e1647997b81c6b7b642a6cd5bf34e2350d80d1e5::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 6, b"SW", b"Sui Water", b"SW is the ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidauum7gclofilwmw5xrdkhk7mrr6iawjpiqpjcw6ws7e7jk4xfgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

