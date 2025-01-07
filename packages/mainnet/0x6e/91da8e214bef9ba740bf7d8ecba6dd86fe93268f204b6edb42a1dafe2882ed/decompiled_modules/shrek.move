module 0x6e91da8e214bef9ba740bf7d8ecba6dd86fe93268f204b6edb42a1dafe2882ed::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 6, b"Shrek", b"Sui Shrek", b"The Shrek that turned blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_VN_Fbl_Dlcr_4f094d22dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

