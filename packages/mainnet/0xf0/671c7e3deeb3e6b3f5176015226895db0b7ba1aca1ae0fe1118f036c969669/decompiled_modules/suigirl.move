module 0xf0671c7e3deeb3e6b3f5176015226895db0b7ba1aca1ae0fe1118f036c969669::suigirl {
    struct SUIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL>(arg0, 9, b"suigirl", b"Suigirl", b"Suigirl is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x6d57f5c286e04850c2c085350f2e60aaa7b7c15b.png?size=lg&key=c66a42")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGIRL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

