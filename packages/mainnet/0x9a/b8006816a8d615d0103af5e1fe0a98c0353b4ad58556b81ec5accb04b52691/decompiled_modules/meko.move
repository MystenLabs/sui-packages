module 0x9ab8006816a8d615d0103af5e1fe0a98c0353b4ad58556b81ec5accb04b52691::meko {
    struct MEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKO>(arg0, 6, b"MEKO", b"Meko On Sui", b"Where the future of digital currency meets the rebellious spirit of the internet's favorite Animal-Cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiael5lkjzf7zfu562awmlx3yxw2kh5hfj3iz2yml5szv5mmxw6izm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

