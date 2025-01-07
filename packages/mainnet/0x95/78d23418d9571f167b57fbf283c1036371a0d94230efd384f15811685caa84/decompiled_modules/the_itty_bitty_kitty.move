module 0x9578d23418d9571f167b57fbf283c1036371a0d94230efd384f15811685caa84::the_itty_bitty_kitty {
    struct THE_ITTY_BITTY_KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE_ITTY_BITTY_KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE_ITTY_BITTY_KITTY>(arg0, 9, b"THE ITTY BITTY KITTY", b"ITTY", b"$ITTY Bitty Kitty is the tiniest, cutest, but also the toughest cat on Sui. The CTO was initiated by an organized group of community members following days of thoughtful deliberation and diligent planning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THE_ITTY_BITTY_KITTY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE_ITTY_BITTY_KITTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THE_ITTY_BITTY_KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

