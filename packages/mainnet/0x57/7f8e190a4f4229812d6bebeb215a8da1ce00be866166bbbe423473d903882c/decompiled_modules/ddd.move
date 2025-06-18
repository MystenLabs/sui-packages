module 0x577f8e190a4f4229812d6bebeb215a8da1ce00be866166bbbe423473d903882c::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"DDD", b"dsikf", b"dsikfdsikfdsikf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblqd7gubfytf6aphc35nkqif37xzff4myrttzfrb2grlfifxfz4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

