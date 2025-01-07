module 0xdf2c274f37fe5e4bac64bde84726444d98ab5fe1ca6039afef0f4a17dca4db4c::aaaduck {
    struct AAADUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADUCK>(arg0, 6, b"AAADUCK", b"aaaduck", b"$aaaaduck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_D_Animation_Style_bebek_warna_biru_0_66227e60e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

