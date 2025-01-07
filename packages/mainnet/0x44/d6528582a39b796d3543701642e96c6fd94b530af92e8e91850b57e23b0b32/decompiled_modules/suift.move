module 0x44d6528582a39b796d3543701642e96c6fd94b530af92e8e91850b57e23b0b32::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 9, b"SUIFT", b"suift", b"just swift", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

