module 0x4bc23d51201775d04aa847acd1a9cc6c29705d33c6b98cc286425228ac21fb53::cak {
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

