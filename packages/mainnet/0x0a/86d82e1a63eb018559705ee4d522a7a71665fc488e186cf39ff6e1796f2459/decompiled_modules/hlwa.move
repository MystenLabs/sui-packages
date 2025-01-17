module 0xa86d82e1a63eb018559705ee4d522a7a71665fc488e186cf39ff6e1796f2459::hlwa {
    struct HLWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWA>(arg0, 6, b"HLWA", b"Hello world 1", b"Test token 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/daossui/assets/tokens/531443a95b484bdc8ed52345b310960b")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLWA>>(v1);
        0x2::coin::mint_and_transfer<HLWA>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLWA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

