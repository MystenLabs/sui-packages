module 0x3e31d1c9e02ca8113510a51b2e8e1a9fd737c244f8bac4f39fd3f3a73ee388ee::junc {
    struct JUNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNC>(arg0, 6, b"JUNC", b"JUNCY", b"$JUNC got more ass than utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihk2je2uqt7yg2lkdka5qlubprgs7g44fgi2hyhfm3lvwnk5jus6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUNC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

