module 0x521ce23762294f8e0852a440a3b9258fb8fc649fc0b0079f001507f655bb3ff::brace {
    struct BRACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRACE>(arg0, 6, b"BRACE", b"LABRACEACCESA", b"LaPrimaMemeCoinTuttaPugliese", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/L-b6sO6rHGI/maxresdefault.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRACE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRACE>>(v2, @0x86e3289eada655152a41cb1045c0b26b3ed981eee9529fcdebda70f2c511595a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

