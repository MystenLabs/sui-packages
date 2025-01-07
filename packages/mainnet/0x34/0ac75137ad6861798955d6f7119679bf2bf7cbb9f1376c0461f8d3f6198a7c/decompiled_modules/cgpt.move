module 0x340ac75137ad6861798955d6f7119679bf2bf7cbb9f1376c0461f8d3f6198a7c::cgpt {
    struct CGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGPT>(arg0, 6, b"CGPT", b"CatGPT on SUI", x"4341544750543a205468652046656c696e652d44726976656e204149204d656d6520436f696e205265766f6c7574696f6e210a68747470733a2f2f742e6d652f43617447505443727970746f426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241201_125951_2_8567532ec9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

