module 0x53104b84216b562b07f6bd51e26c6fda6178997301a5b73efda7c99da09af9fe::mika {
    struct MIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKA>(arg0, 9, b"MIKA", b"Mika", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8ZFVPK68zMz34QoM9yH7ZWJemetkkB1y5A1uWx3EjBZw.png?size=xl&key=9fd9cb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

