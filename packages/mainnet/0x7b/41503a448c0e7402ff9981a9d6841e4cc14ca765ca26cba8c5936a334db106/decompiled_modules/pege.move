module 0x7b41503a448c0e7402ff9981a9d6841e4cc14ca765ca26cba8c5936a334db106::pege {
    struct PEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEGE>(arg0, 6, b"PEGE", b"PegeCoin", b"$PegeCoin - Born to meme. Officially Endorsing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifip5llfjucolvrjsoqix6xtyjo7zs4qne7sriqbwqcrynylimgdu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

