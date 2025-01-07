module 0xacc8ed8fec5b8fb202a33fa48a8af4694e98bccef6eca84e554bac9ad48bdf3e::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"MOJO ON SUI", x"48492c2049276d204d6f6a6f206f6e2053554920616e642049276d2074686520666972737420696c6c757374726174696f6e20647261776e206279204d61747420467572696520696e20313938352e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QD_Qsl_Gk_E_400x400_fd99d6849c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

