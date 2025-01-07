module 0x557615c7bd61eefa806bd6af1e1d0359816f2f570a899b9c0fd2681c622b1b79::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"WOOF SUI", x"446f6773206c6561642c206361747320666f6c6c6f77207c2024574f4f46207c20207c2030352e31310a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ILRR_Ye_Kv_400x400_2e5e165052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

