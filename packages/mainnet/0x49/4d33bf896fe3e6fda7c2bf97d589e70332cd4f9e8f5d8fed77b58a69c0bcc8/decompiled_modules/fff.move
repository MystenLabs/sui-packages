module 0x494d33bf896fe3e6fda7c2bf97d589e70332cd4f9e8f5d8fed77b58a69c0bcc8::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"SSSSS", b"GFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia4twz3gb76fwptlneyohjkheaxhomp5xkhutqt5pcd7mdt7qqf5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

