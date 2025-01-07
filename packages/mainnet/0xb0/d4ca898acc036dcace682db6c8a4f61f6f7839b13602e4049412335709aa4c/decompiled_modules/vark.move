module 0xb0d4ca898acc036dcace682db6c8a4f61f6f7839b13602e4049412335709aa4c::vark {
    struct VARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VARK>(arg0, 6, b"VARK", b"VARK VARK", b"VARK on movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Lpn_Ty_JWAAAB_34_M_2848f72c99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

