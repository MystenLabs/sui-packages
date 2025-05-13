module 0x8c374bb71305a95935388caf0c8742707d324efc8c9c066b2abf3c10789eee1d::mun {
    struct MUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN>(arg0, 6, b"MUN", b"Retard Moon", b"Retarded Moon on Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibt4vk2lyimubb2qyqhyfd66rrjqzkvmgfqaru5gdudh3zedn337a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

