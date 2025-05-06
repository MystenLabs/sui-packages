module 0x93cdf141bfaf99d34a8aad4b9aa6f8b3602d9ed2847b1806df6840a57fe6dd19::test9 {
    struct TEST9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST9>(arg0, 6, b"TEST9", b"TEST TOKEN 9", b"DON'T BUY THIS COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihzzmbmernlgsgzhvzfc3bmgrrhdpspbbee5i65ogblhr643cjnky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST9>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

