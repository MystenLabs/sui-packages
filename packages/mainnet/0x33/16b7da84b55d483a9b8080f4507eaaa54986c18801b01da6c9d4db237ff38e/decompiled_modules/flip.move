module 0x3316b7da84b55d483a9b8080f4507eaaa54986c18801b01da6c9d4db237ff38e::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"FLIP", b"SuiFlip", b"SuiFlip is an experimental project built on the Sui ecosystem. Currently in early development, it showcases our vision of creating a seamless and engaging platform for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifa2jerusboh6x2eff3d4lvoli5rahjzb6qd7ie4iqfey3pxucply")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

