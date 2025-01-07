module 0x38a70053fc1f2aec34508b4927d9a03d6cf4c67a38c1a9141423f51f317ba28e::burger {
    struct BURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURGER>(arg0, 6, b"BURGER", b"Crypto Burger", x"43727970746f20427572676572202d205468652066697273742024425552474552206f6e2053554920466f726d657220555320507265736964656e74205472756d70206f6e636520616761696e20626f756768742061206275726765722077697468204254432120546f20636f6d6d656d6f726174652074686973206d696c6573746f6e652c2074686520627572676572202242555247455222207468617420697320656e67726176656420696e2074686520686973746f7279206f662063727970746f63757272656e636965732063616d6520696e746f206265696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BURGER_T_Dbhi_U_7ti5r_U_Aq_Ru_NJ_15605e3342.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

