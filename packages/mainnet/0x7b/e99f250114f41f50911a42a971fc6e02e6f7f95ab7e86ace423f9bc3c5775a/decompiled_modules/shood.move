module 0x7be99f250114f41f50911a42a971fc6e02e6f7f95ab7e86ace423f9bc3c5775a::shood {
    struct SHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOOD>(arg0, 6, b"SHOOD", b"Sui Hood", b"Join The Gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsxsnsjv6kews3ljfmlezleznsj3rsyvwgqeqvtb4pnzv3l3qzc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

