module 0x2e1f69b902a2e488500503426d311d8725ffe35be1123004a0527847af17d747::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"Trump", b"McTrump", b"\"Flipping burgers, flipping polls!  McTrump is here to serve you presidential vibes with a side of fries. Whether you're bullish or just craving some spicy debates, grab your McTrump coins and lets fry the competition. 'Because who needs policies when you've got Happy Meals?'\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_14_17_55_eb441c253a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

