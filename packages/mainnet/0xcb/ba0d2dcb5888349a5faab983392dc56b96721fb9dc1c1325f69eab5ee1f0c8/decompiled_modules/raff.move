module 0xcbba0d2dcb5888349a5faab983392dc56b96721fb9dc1c1325f69eab5ee1f0c8::raff {
    struct RAFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAFF>(arg0, 9, b"RAFF", b"RAFF the Giraffe", b"HI I'M RAFF THE GIRAFFE FROM THE LAND OF Solana and my owner left me for dead. I was saved and found by a Bus load of futurists I have chin balls now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CEv97t1Qp7FB6XX1PH5ohyrzUCeKAQbCpAjxegJq9HW7.png?size=lg&key=bc5ae8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAFF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAFF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

