module 0x73fd3798ee113b5e82a6bd2d97a62b1d0e0b36e79ecd52683c2f4743a59e0edf::generis {
    struct GENERIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENERIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENERIS>(arg0, 6, b"GENERIS", b"Sui Generis", b"Public sale for the 1st On-chain DAO on SUI, NFTs hub for 1:1 arts, Live auctions and Blue Chips Collections on Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_4c5cef3237.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENERIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENERIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

