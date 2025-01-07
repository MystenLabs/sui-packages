module 0xf83e2dc1a0a15715dc7169a45c67e658a009ffdd9fa49c5a29df0765ead77a23::qoat {
    struct QOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QOAT>(arg0, 9, b"QOAT", b"Quantum Gospel", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7F9bK2Gj7X5YY3dYfojoWVQYerFYcaGCni6Czt8Xpump.png?size=lg&key=19dcaa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QOAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QOAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

