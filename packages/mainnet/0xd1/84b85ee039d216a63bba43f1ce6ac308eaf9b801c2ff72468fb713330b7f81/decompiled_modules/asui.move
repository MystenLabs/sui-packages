module 0xd184b85ee039d216a63bba43f1ce6ac308eaf9b801c2ff72468fb713330b7f81::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 9, b"ASUI", b"AmericanSui", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/69kdRLyP5DTRkpHraaSZAQbWmAwzF9guKjZfzMXzcbAs.png?size=xl&key=006a81")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASUI>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

