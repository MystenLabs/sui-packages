module 0x3489a476f62abf374c6df37474e0cebb95e7ca20b5c9f5281f92719b20431685::suigroupman {
    struct SUIGROUPMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGROUPMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGROUPMAN>(arg0, 6, b"SUIGROUPMAN", b"Sui Group Man", x"496e737069726564206279207468652069636f6e696320426c7565204d616e2047726f75702c202453554947524f55504d414e206272696e67732072687974686d2c20637265617469766974792c20616e6420616e206f74686572776f726c646c79207669626520746f2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_0ef8db26f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGROUPMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGROUPMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

