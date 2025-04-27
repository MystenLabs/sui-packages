module 0x7a4d2d83dea094a0c0eb95023cb20a2a089db78b9abe78a201a289907af25748::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"PUGGYDOG", x"5055474759444f4720697320746865206d6f737420636f6f6c65737420616e64206472697070696e272064617767206f6e0a537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiem6532drki7zlblfsxpokushbnj4nkvxzlhvv7pcxi4zwk7b4dqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

