module 0x7d928e8b13f5f983ea343e92b44817c6cac100b20c13051bfdd079ae13905213::bst {
    struct BST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BST>(arg0, 9, b"BST", b"BEST", b"BST - the best meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BST>>(v1);
    }

    // decompiled from Move bytecode v6
}

