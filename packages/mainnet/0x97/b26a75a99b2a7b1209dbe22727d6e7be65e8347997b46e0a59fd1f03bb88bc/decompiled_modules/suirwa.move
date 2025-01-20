module 0x97b26a75a99b2a7b1209dbe22727d6e7be65e8347997b46e0a59fd1f03bb88bc::suirwa {
    struct SUIRWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRWA>(arg0, 9, b"SUIRWA", b"Sui RWA", b"SuiRWA is an advanced ecosystem on the SuiNetwork! Where users can engage with thousands of AI agents, each specializing in different investment strategies, particularly within the Real World Asset (RWA) sector. From real estate to tokenized stocks, commodities & more!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1877425573443555328/CVzsXUha_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIRWA>>(0x2::coin::mint<SUIRWA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIRWA>>(v2);
    }

    // decompiled from Move bytecode v6
}

