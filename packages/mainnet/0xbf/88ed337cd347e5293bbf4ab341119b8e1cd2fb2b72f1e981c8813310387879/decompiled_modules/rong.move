module 0xbf88ed337cd347e5293bbf4ab341119b8e1cd2fb2b72f1e981c8813310387879::rong {
    struct RONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONG>(arg0, 9, b"RONG", b"Rong", b"Best coin ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://white-wild-hyena-758.mypinata.cloud/ipfs/QmTDtMfxXxsfe2awsS62qn8skdU2VqGZx8gmjJS9CGmoEk?_gl=1*1lw8mcm*_ga*MTI4Nzk1MzM5Mi4xNjg0NTc1MDU4*_ga_5RMPXG14TE*MTY5OTYxMTIyMi44LjEuMTY5OTYxMTMwMy40Ni4wLjA.")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

