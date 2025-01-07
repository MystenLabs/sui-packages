module 0x6363e522e5f14cf271bfaacfdbc59cb67e881d7c2b0f2453aea79bc3df1c485f::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 9, b"BTS", b"BTS", b"BTS - Kpop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://n1s1.hsmedia.ru/59/b4/8c/59b48c85be136d691b73de05754e27c5/600x600_1_bd8fa1bc1fe98e76b2090e3ccb08bca2@2048x2048_0xIERR1fhN_7413448315464806659.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTS>(&mut v2, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

