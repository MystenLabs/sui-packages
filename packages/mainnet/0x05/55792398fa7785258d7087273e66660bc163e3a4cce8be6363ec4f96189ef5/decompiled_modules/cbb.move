module 0x555792398fa7785258d7087273e66660bc163e3a4cce8be6363ec4f96189ef5::cbb {
    struct CBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBB>(arg0, 6, b"CBB", b"Caty with Blue Ballon", b"Caty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiakjyrqmqtpyl7zpw2fejzpxvnnxgw2tafr6txfjf2pjdrrrvwwj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CBB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

