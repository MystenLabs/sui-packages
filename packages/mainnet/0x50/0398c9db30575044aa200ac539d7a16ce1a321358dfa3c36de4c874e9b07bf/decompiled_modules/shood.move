module 0x500398c9db30575044aa200ac539d7a16ce1a321358dfa3c36de4c874e9b07bf::shood {
    struct SHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOOD>(arg0, 6, b"SHOOD", b"SUIHOOD", b"SUIHOOD GANGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsxsnsjv6kews3ljfmlezleznsj3rsyvwgqeqvtb4pnzv3l3qzc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

