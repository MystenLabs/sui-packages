module 0xd81c0e6863f28725f91aa2f41a64725f6e06f93a07a8fc21d40db87f5fae7dee::jiggo {
    struct JIGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGO>(arg0, 6, b"JIGGO", b"JIGGOLONI", b"JIGGOLONI is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdcu3h6v32lm37vvzbkaywfwcnf2hcy7fxiz25axmhr5c5uox5tu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

