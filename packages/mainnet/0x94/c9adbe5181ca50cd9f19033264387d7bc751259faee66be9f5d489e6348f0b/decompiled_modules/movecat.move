module 0x94c9adbe5181ca50cd9f19033264387d7bc751259faee66be9f5d489e6348f0b::movecat {
    struct MOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECAT>(arg0, 6, b"MOVECAT", b"MOVE SUI CAT", x"546865204f472043617420436f696e206f6e205375690a47657420696e206f6e207468652067726f756e6420666c6f6f722077697468205375692043617420616e642062652070617274206f6620746865204f472063617420636f696e207265766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_BC_0_BE_88_1_A55_4999_8_ECD_275867_AB_2_C81_e335249b08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

