module 0x4df28e95cc8cb636ae17c175eb03e91ffa0d547527878ef5878aa08d62cb3dce::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 9, b"CAP", b"CAP", b"CAP COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

