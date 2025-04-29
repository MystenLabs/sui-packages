module 0xe3a095e1bc11fc74ca570ec96b67ab54d0130f925b4f32c79b13da6dbacbc5b5::dok {
    struct DOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOK>(arg0, 6, b"DOK", b"DOg King", b"King king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic2k7hdapfanqdcxm4eioamaw3quamla432d6cjdsl6rlo455j2wi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

