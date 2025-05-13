module 0x4c84fa4e939f28f871d9416ecf42f4176907b61dc7005570df8e8fd42d96b12::suikyu {
    struct SUIKYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKYU>(arg0, 6, b"SUIKYU", b"Suikyu Pokemon", b"Buiding pokemon game on Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibq7brileb3npukkepr4pvvtrsfmavnnvmgawf3t5agd7r627lcsi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKYU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

