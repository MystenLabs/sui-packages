module 0x34265297248f8d8604837bf3abd10a5656e37ce2fbe93ea8fe448dc84828681c::spain {
    struct SPAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAIN>(arg0, 9, b"Spain", b"Spain", b"Spain without the s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPAIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

