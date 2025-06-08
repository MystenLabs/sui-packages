module 0x174b09d2e5d7b9c28012d4fd36699fe8cfae1570b3d1c279e0a2ce84fff42463::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTER>(arg0, 6, b"MONSTER", b"MONSTERSUI", x"4d4f4e535445525355490a4d4f4e53544552204f462054484520535549204e4554574f524b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid6q7luv4riggqd6yrjy7kapwgrsqkis7ud3se724vcgdcvvdmi4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONSTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

