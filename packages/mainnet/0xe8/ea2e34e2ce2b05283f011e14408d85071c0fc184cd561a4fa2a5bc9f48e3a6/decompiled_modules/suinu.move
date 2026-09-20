module 0xe8ea2e34e2ce2b05283f011e14408d85071c0fc184cd561a4fa2a5bc9f48e3a6::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 9, b"SUINU", b"SuInu", b"Suinu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/80dfede12b30db05e1258e8e355631847011f2a5ef3daab1c84827198715170c")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINU>>(0x2::coin::mint<SUINU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

