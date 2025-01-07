module 0xb50c159f5603cd1d56c665025ab37f5d193db2c426d0fcdc4c862e28d1531b80::mcup {
    struct MCUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCUP>(arg0, 6, b"MCUP", b"Meme CUP", b"Meme CUP pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMmsrcAd7-mhPfbF72TzBhdTvvETkWMu7Eug&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCUP>(&mut v2, 480000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

