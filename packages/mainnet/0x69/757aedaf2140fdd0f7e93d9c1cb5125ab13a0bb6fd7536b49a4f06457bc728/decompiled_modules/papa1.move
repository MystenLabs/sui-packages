module 0x69757aedaf2140fdd0f7e93d9c1cb5125ab13a0bb6fd7536b49a4f06457bc728::papa1 {
    struct PAPA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA1>(arg0, 9, b"PAPA1", b"PAPA", x"457863656c6c656e742073757065722064757065722066756e206d656d652e616c6c2062726f2e736d616c6c20616d6f756e7420627579696e6720f09f94a520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4982668e0997f679b82641c4af34f708blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPA1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

