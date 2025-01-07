module 0xe360ae9e0b4f41e09c67e65a62d239390189df2f90df0f11c2920dd4eac70308::lymp {
    struct LYMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYMP>(arg0, 6, b"LYMP", b"LYTOMP", b"simply create salty jokes to create a token interest home fiery flight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fire_scaled_jw_C_Wf0_G6f6_59bdb08a1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

