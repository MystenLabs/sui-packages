module 0x10b81e70fa52d5f00ebfa7e85e67aee9854ebabbe1a4a8c13054d65081bd47ad::cak {
    struct CAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000;
        let (v1, v2) = 0x2::coin::create_currency<CAK>(arg0, 6, b"Raise 17", b"Also Raise 17", b"__Description here__", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"__Url here__")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAK>>(v2);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0xd5289d34a97f96455ea9c4f94adac19722ccf2db108442f1f1af0c398e4eb912, arg1);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0x306d9512eaf0859184a301847e97311d5f17bd00c661f2ffab9c2523327e6d9c, arg1);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0x3490fb20db6f70ea3cdbe00bf9050267d827ea1bbb1a0f2c5c9889f1c242d398, arg1);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0xd77fcf84aa1eb043dae42888db1e38ce7633a25d5a5b30bf7aa57bbd1fd5519d, arg1);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0x7096a8d15d437e24ed6d0654419319741b180baed83825055148937f58b23e2a, arg1);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0x6c581348d2b6e9ddaf91e2eff469a1d4a355b86ed7e2ec99e3f05a820edc2180, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAK>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

