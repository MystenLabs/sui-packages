module 0x73ce34700ebbfc46d9f871e45c612baa88e73393396fe2a8c6ae60e5d0501137::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STR>(arg0, 9, b"STR", b"STR", b"STR. gem. alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STR>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STR>>(v1);
    }

    // decompiled from Move bytecode v6
}

