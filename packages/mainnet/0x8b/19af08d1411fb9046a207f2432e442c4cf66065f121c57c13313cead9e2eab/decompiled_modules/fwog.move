module 0x8b19af08d1411fb9046a207f2432e442c4cf66065f121c57c13313cead9e2eab::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"Fwog On Sui", b"Just a Lil Fwog in the Sui Pond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdu3bxswzmgcrnog2qsfbxrcwj5hxy43434f4rsr6g7kzvjm555a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

