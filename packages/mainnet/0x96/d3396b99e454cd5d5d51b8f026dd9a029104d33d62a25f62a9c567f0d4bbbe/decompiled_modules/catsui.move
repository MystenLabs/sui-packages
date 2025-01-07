module 0x96d3396b99e454cd5d5d51b8f026dd9a029104d33d62a25f62a9c567f0d4bbbe::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATSUI>, arg1: 0x2::coin::Coin<CATSUI>) {
        0x2::coin::burn<CATSUI>(arg0, arg1);
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 9, b"CATSUI", b"CATSUI", b"https://ibb.co/6t6WrGB", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CATSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

