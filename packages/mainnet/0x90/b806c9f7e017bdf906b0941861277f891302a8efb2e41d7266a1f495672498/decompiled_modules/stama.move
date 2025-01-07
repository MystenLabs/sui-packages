module 0x90b806c9f7e017bdf906b0941861277f891302a8efb2e41d7266a1f495672498::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 6, b"STAMA", b"stama  on sui", x"245354414d412068747470733a2f2f742e6d652f73756974616d61636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_1ia_N7n_400x400_b628a09b6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

