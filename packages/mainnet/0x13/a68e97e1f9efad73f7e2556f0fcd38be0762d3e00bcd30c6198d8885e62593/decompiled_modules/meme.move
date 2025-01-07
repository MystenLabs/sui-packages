module 0x13a68e97e1f9efad73f7e2556f0fcd38be0762d3e00bcd30c6198d8885e62593::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: 0x2::coin::Coin<MEME>) {
        0x2::coin::burn<MEME>(arg0, arg1);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 18, b"MEME", b"MEME Exchange", b"MEME Exchange, Mining Pool, Defi, Launch Pad, Top MEME exchange, DAO Community Governance Exchange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreifhn6kn2rsvjztb6lgfhatkt4ottwzavzjelw6wnu5zxws67szvgm.ipfs.nftstorage.link/"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEME>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MEME>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME>>(arg0);
    }

    // decompiled from Move bytecode v6
}

