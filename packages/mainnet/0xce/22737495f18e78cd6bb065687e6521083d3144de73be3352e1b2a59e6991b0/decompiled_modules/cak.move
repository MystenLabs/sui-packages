module 0xce22737495f18e78cd6bb065687e6521083d3144de73be3352e1b2a59e6991b0::cak {
    struct CAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000;
        let (v1, v2) = 0x2::coin::create_currency<CAK>(arg0, 6, b"Raise", b"__name here__", b"__Description here__", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"__Url here__")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAK>>(v2);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0x3490fb20db6f70ea3cdbe00bf9050267d827ea1bbb1a0f2c5c9889f1c242d398, arg1);
        0x2::coin::mint_and_transfer<CAK>(&mut v3, v0, @0x7096a8d15d437e24ed6d0654419319741b180baed83825055148937f58b23e2a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAK>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

