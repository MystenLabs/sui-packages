module 0x1d2a292ef79e0d11517c0d63a0258146611bee478c9b32e15f7972f26b470c93::suied {
    struct SUIED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIED>(arg0, 6, b"SUIED", b"SUIED-UP", x"466f7220746865204c6f7665206f6620245375690a456c6f6e20616e6420446f6e616c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B386_CBF_8_D5_A3_4552_806_B_89_DDC_33_C7_F55_65f1a2ba95.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIED>>(v1);
    }

    // decompiled from Move bytecode v6
}

