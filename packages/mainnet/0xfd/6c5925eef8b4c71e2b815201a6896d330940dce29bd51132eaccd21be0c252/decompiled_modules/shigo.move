module 0xfd6c5925eef8b4c71e2b815201a6896d330940dce29bd51132eaccd21be0c252::shigo {
    struct SHIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIGO>(arg0, 6, b"SHIGO", b"Shiba Gio", x"53686962612047696f20697320612070757265206d656d6520666f7263652c206e6f20726f61646d61702c206e6f2070726f6d697365732c206e6f20736f6369616c732e204a7573742076696265732c20636f6d6d756e6974792c20616e64206368616f732e0a426f726e2077697468206e6f206d61737465722c206e6f206f6666696369616c207465616d2c20616e64206e6f2063656e7472616c697a656420706c616e2c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietax6x2gzb54hbujk6qmc4x4f2b2b2urxwxd4vjvve3gsrhlqcuq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

