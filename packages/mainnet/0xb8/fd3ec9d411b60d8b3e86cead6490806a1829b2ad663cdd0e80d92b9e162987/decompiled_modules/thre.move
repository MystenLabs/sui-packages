module 0xb8fd3ec9d411b60d8b3e86cead6490806a1829b2ad663cdd0e80d92b9e162987::thre {
    struct THRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THRE>(arg0, 6, b"THRE", b"MewThre", b"MEWTHREE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidhzltwucyt64t5o6ctdsndh55lvzzicjvehjmoco243byjzegq7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

