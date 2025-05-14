module 0x8824e23152fa462a722cb9df54f2f225f4ed6f3a89d03ef6bec3f85a5477288e::whirl {
    struct WHIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHIRL>(arg0, 6, b"WHIRL", b"Poliwhirl", b"Poliwhirl: The Mascot You Never Knew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiferbz3qcshqpwvjju23lc6kzrtw4xgaz2cmogoxe2kwsykuhyfgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHIRL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

