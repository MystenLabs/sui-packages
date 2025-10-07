module 0x30b5b5f1e128e619fb4b40748cec6f2467cfb2374a8cc3ad9778ffdfbaa18c3c::monkito {
    struct MONKITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKITO>(arg0, 9, b"MONKITO", b"MONKITO", x"4d6f6e6b69746f20284d4f4e4b49544f2920e28094206120746f6b656e2064657369676e656420666f7220696e6e6f766174696f6e2c2067726f7774682c20616e64206c6f6e672d7465726d20636f6d6d756e6974792076616c75652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmPHBRdcp5hdmicU3m6TTs2NzmSkF5pKTWjsSgNtZ1a7Wt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONKITO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKITO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

