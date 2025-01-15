module 0xd303acedcff38ce8aa8dcc2b3d6f206681dd0bf11aa214770a60d63b885c4cf5::cak {
    struct CAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAK>(arg0, 6, b"Payment 17", b"Payment 17", b"__Description here__", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"__Url here__")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAK>>(v1);
        0x2::coin::mint_and_transfer<CAK>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

