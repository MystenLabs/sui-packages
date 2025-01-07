module 0x26c47ef84923ebc9c04998378807e8f05a6d1181a4edb74d62676ffa2f832ad9::pangjim {
    struct PANGJIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANGJIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANGJIM>(arg0, 9, b"PANGJIM", b"Pangjim", b"Pang Jim - Elephant Swimming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9kahs6tASfXb8wXhC9g54mYA7e33XzmksYdpjQBDpump.png?size=xl&key=2b1fe2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PANGJIM>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANGJIM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANGJIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

