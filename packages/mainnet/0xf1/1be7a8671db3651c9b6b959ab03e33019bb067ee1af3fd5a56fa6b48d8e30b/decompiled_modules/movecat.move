module 0xf11be7a8671db3651c9b6b959ab03e33019bb067ee1af3fd5a56fa6b48d8e30b::movecat {
    struct MOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECAT>(arg0, 6, b"MOVECAT", b"MOVE SUI CAT", x"457665727920636861696e206e6565642063686174204d4f564550554d50206e6565642063617420244d4f56454341540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_BC_0_BE_88_1_A55_4999_8_ECD_275867_AB_2_C81_d62dd114f1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

