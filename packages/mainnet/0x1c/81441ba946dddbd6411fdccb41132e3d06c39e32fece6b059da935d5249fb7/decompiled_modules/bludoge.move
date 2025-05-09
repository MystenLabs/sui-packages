module 0x1c81441ba946dddbd6411fdccb41132e3d06c39e32fece6b059da935d5249fb7::bludoge {
    struct BLUDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUDOGE>(arg0, 6, b"BLUDOGE", b"BLUDOGE COIN", x"426c75646f67652069732074686520616c70686120646f67206f662074686520537569206e6574776f726b2c206272696e67696e672074686520737472656e67746820616e64206d617363756c696e69747920746f20746865206661737465737420626c6f636b636861696e2061726f756e642e200a48652773206e6f74206a7573742061626f757420737472656e6774683b2020426c75646f676520697320616c736f2074686520736d61727465737420646f67206f6e205375692c206c656164696e6720746865207061636b207769746820686973207368617270206d696e6420616e6420717569636b207769742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuzeg57rl53yuxzwkaclvgpkl5ecqufuhiqkwt2ht2z4z6dpaiee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

