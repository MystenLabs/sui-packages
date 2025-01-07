module 0x9402b1bd431c9c5a7e0edecfa41023e9d3772d8b748992edf8fa036fa23db7b6::BOG {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 8, b"BOG", b"Sui Bog", b"Bog is a whimsical character created by Matt Furie in 2000, marking the beginning of his unique universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmUqLSVKgN6kQNv2F9zjkwH5nV2E3c9rXf9WvfpqR64NrE?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOG>>(0x2::coin::mint<BOG>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOG>>(v2);
    }

    // decompiled from Move bytecode v6
}

