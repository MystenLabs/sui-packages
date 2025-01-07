module 0xc9d1030bc28d5e5b47ca9a776179cb9e3f2c91e77156c93a4f3b736f6355c9dd::apple {
    struct APPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPLE>(arg0, 9, b"Apple", b"Apple", b"Apple Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APPLE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

