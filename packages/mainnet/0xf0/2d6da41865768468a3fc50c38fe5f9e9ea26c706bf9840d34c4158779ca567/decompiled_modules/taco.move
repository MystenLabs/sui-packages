module 0xf02d6da41865768468a3fc50c38fe5f9e9ea26c706bf9840d34c4158779ca567::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACO>(arg0, 6, b"TACO", b"TACO on SUI", x"4d656574205461636f2c206120726573637565642074776f2d66696e676572656420736c6f74682077686f206861732064656669656420746865206f64647320616e642063617074757265642074686520686561727473206f662070656f706c6520657665727977686572652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2w_IA_Ua_D_400x400_564e565290.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

