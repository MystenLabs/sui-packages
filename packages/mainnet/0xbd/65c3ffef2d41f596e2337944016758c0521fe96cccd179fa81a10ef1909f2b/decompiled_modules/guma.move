module 0xbd65c3ffef2d41f596e2337944016758c0521fe96cccd179fa81a10ef1909f2b::guma {
    struct GUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMA>(arg0, 9, b"guma", b"guma", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

