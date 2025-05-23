module 0x7017385b517144f04f6f832157bb22eb55a6e9efbab4e91c2b4c0faed319eefa::hhhhhhh {
    struct HHHHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHHHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHHHHHH>(arg0, 6, b"HHHHHHH", b"Hdhdh", b"Jdjdsvisjacwccwcc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig43baab56ghoayrcpmhz4l6b74dui5cqfbazmwvaqv3uijd3vgxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHHHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHHHHHH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

