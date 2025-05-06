module 0xabbd8c160859860fdaceb0ba7c6ae640ee8503216763bb7c1bf9a00c62886cda::test8 {
    struct TEST8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST8>(arg0, 6, b"TEST8", b"TEST TOKEN 8", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidjyvw2xoioeoxfiwv2djjen2rjsqwyzo52c3pi4xvnixdznoimka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST8>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

