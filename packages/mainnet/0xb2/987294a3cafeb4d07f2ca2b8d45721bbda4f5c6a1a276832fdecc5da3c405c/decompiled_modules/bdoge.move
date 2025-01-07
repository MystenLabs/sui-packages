module 0xb2987294a3cafeb4d07f2ca2b8d45721bbda4f5c6a1a276832fdecc5da3c405c::bdoge {
    struct BDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOGE>(arg0, 8, b"BDOGE", b"Doge But Blue", b"Doge, a blue-colored dog, unlike any other. With a shimmering coat of deep blue, Doge is a symbol of uniqueness and allure. Not just a dog, Doge is also an inspiration and joy to everyone around. With gentle eyes and attentive ears, Doge is always ready to share happiness and love. Come and explore the magical world of Doge, where all wonders become reality!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x4c9f149825dd84b9b938916ee618e5283168fbd7.png?size=xl&key=bfb8db")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BDOGE>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

