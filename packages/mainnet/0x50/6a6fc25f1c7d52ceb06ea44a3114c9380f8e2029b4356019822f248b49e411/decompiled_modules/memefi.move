module 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi {
    struct MEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEFI>(arg0, 9, b"MEMEFI", b"MEMEFI", b"MEMEFI is a community-driven token powering the MemeFi consumer ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.memefi.club/landing/logo/memefi.svg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEFI>>(v1);
        0x2::pay::keep<MEMEFI>(0x2::coin::from_balance<MEMEFI>(0x2::coin::mint_balance<MEMEFI>(&mut v2, 10000000000000000000), arg1), arg1);
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::treasury::share<MEMEFI>(0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::treasury::wrap<MEMEFI>(v2, arg1));
    }

    // decompiled from Move bytecode v6
}

