module 0x2f7ce45b3cc5bfdf68f4e4d655eea6777c9aea12256c336e751402761c943630::fuxi {
    struct FUXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUXI>(arg0, 6, b"FUXI", b"Fuxi", x"467578692077617320612063756c74757265206865726f20616e6420676f6420696e204368696e657365206d7974686f6c6f67792c20726576657265642061732074686520676f64206f662068756d616e6974792c20636976696c697a6174696f6e2c20616e64206f726465722e206d7974686f6c6f676963616c2072756c6572732077686f20776572652062656c696576656420746f20686176652074617567687420657373656e7469616c20736b696c6c7320666f722068756d616e20737572766976616c20616e6420646576656c6f706d656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_19_09_11_0cdae11c76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

