module 0xe996ef1d9637769c3b52eb8dc4de24c8f0c90b914221e3ef582406c77c1a9bcf::odd {
    struct ODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODD>(arg0, 6, b"ODD", b"ODD DUCK", x"426520446966666572656e74202d204275696c6420616e6420737570706f727420656163686f74686572206173206120636f6d6d756e697479200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9527_00ede57492.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

