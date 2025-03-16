module 0xd29d92c1db04711b7cf5f75d4033bde794d49bff7c1c945e2ec38ad676666c2d::pikachu {
    struct PIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHU>(arg0, 9, b"PIKACHU", b"Pikachu", b"Pika Pika", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTjDiZ7VBj2aHcFhajv9wnFA9U5nzqzFfzrgBU1RHCWgm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKACHU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKACHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

