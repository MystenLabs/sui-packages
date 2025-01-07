module 0x6277b94c378540b8f59440c13a955883de1eb83098a43fa77bca5013c0d24b0f::fibl {
    struct FIBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIBL>(arg0, 6, b"FIBL", b"FIBL ON SUI", b"Official FIBL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1731364551_6052861_3_ED_42301_4_D1_D_4_C45_A7_F2_B43_D69_B1_F389_f40b377850.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

