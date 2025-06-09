module 0x2649082ec978464c69650cac50638ab5b00668aff55c452701fc9ac625cb319a::se {
    struct SE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SE>(arg0, 6, b"SE", b"Sui Eagle", b"first eagle on sui, let's make it fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibcawo7qpakcohgzqejpnel4sfvnd6bqnxnnbunhxrrivedg5nc6q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

