module 0x18c6188b374693657618eb4b3b650c65d70290fa8fa58fe30d403aba06e5b42a::fruits {
    struct FRUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUITS>(arg0, 6, b"FRUITS", b"Fruits Sui", b"FRUITS is a perfect example of how a meme-based project can evolve into a complex and highly valuable ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifbulaf27bmroaqhtlsdp6dzo7qgxstk65gveoziyrcym6w6e3rky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRUITS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

