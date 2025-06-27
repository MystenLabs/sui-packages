module 0x76f9f193dbbba0732b4c93edd754879e76cb7c72ad0b74ce0327b1c08325d06d::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 6, b"MSGA", b"Make Sui Great Again", x"244d534741206973207468652068617420796f752077656172207768656e20796f752772652062756c6c697368206f6e2074686520636f6d656261636b2e0a54686520766f6c756d652072657475726e73207768656e20746865206d656d6573207374617274206d61726368696e672e204c4647210a4d656d652d706f77657265642e200a566f6c756d652d64726976656e2e200a436f6d6d756e6974792d6675656c65642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiax52n2evgcahwkxjacmk6c2bupkmgdndfzd6ulghxab32zmbbdi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MSGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

