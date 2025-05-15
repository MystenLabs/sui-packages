module 0x9ef102955c1460e3872a32359f8cc58b125b1b19eed3d03a1f3f625ce7b13e95::home {
    struct HOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOME>(arg0, 6, b"HOME", b"Home On Sui", x"486f6d6520204f6e205375690a0a4d6f726520696e666f20736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicf2ugzu4rq4vlyk7hdybwan4zmn5ndep47yz6t5tc6nexi6mrxgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

