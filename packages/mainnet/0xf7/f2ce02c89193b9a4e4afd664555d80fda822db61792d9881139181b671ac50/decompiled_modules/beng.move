module 0xf7f2ce02c89193b9a4e4afd664555d80fda822db61792d9881139181b671ac50::beng {
    struct BENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENG>(arg0, 6, b"BENG", b"SUI BENG", b"ni hao, ju da de beng. be the SUI pump you want to see. respect the beng.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1149_ba974887d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

