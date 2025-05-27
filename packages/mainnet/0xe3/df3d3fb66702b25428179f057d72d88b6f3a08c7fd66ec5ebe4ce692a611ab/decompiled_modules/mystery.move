module 0xe3df3d3fb66702b25428179f057d72d88b6f3a08c7fd66ec5ebe4ce692a611ab::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"MYSTERY", b"Project Mystery", x"4d7973746572792050726f6a65637420636f6d696e6720696e2024535549204e6574776f726b2e0a4372656174656420616e64206265696e6720646576656c6f706564206279206f6e65206f6620746865206d6f7374206b6e6f776e20616e642070726573746967696f7573207465616d20696e20534f4c414e412e0a0a4d7973746572792077696c6c20756e6c6f636b20736f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidiokuxmmgmgm7fsei35qnv5k55cwyff6pzf4wbtp3aexsmdetv4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MYSTERY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

