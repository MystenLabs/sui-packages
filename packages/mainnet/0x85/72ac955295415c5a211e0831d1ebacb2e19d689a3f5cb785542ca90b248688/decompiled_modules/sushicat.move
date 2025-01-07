module 0x8572ac955295415c5a211e0831d1ebacb2e19d689a3f5cb785542ca90b248688::sushicat {
    struct SUSHICAT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUSHICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUSHICAT>>(0x2::coin::mint<SUSHICAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUSHICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHICAT>(arg0, 6, b"SUSHI BLUE CAT", b"SushiBlueCat", b"SUSHI BLUE CAT MEME COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSHICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

