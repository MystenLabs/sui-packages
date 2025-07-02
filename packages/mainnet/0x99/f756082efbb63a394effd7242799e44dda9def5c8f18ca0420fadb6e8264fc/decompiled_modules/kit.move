module 0x99f756082efbb63a394effd7242799e44dda9def5c8f18ca0420fadb6e8264fc::kit {
    struct KIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIT>(arg0, 6, b"KIT", b"KITA", b"kita is a meme coin built on the sui blockchain representing fun freedom and community power it stands for kick in the ass and brings playful energy to the crypto world with a colorful bold identity kita challenges the usual norms of crypto by being wild energetic and community focused its logo features a swirl of vibrant colors showing the spirit of chaos and humor that defines the coin powered by sui it offers speed scalability and decentralization while aiming to be a strong contender in the meme coin space with planned airdrops community events and surprises kita is made to entertain engage and empower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieladdtdh4kcrol7wzgm6fitwduoqlsumpy2upxrlmrtbnnw2dqlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

