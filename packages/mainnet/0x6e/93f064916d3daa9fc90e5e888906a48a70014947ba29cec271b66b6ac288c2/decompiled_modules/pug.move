module 0x6e93f064916d3daa9fc90e5e888906a48a70014947ba29cec271b66b6ac288c2::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"Pug", b"Puggy dog on sui", x"5055474759444f4720697320746865206d6f737420636f6f6c65737420616e64206472697070696e272064617767206f6e0a537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4lyoy6w6mhh3j4w6byz5svvqhkeflkiur4t6hjjkf4be3kpqovu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

