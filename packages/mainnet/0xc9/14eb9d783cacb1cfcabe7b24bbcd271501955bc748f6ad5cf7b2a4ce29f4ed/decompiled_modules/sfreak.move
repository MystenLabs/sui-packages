module 0xc914eb9d783cacb1cfcabe7b24bbcd271501955bc748f6ad5cf7b2a4ce29f4ed::sfreak {
    struct SFREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFREAK>(arg0, 6, b"SFREAK", b"FREAK ON SUI", b"Be weird. Be wild. Be freak.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifsaaz5tb7hjxaekfg3zesvrol5tkozgdxexft7q2ywr53oagxjwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFREAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

