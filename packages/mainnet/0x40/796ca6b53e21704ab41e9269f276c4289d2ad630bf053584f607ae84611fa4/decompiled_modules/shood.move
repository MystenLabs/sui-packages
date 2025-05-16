module 0x40796ca6b53e21704ab41e9269f276c4289d2ad630bf053584f607ae84611fa4::shood {
    struct SHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOOD>(arg0, 6, b"SHOOD", b"SUI HOOD", b"Join The Gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsxsnsjv6kews3ljfmlezleznsj3rsyvwgqeqvtb4pnzv3l3qzc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

