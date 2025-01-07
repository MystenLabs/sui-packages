module 0x806f59c79d9db5a63184ceff89f8bf696548a45c8aae4fe9fe84393036839ed3::skbdi {
    struct SKBDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKBDI>(arg0, 6, b"SKBDI", b"Skibidi Toilet", b"First Skibidi Toilet On Sui .Website: https://skbdionsui.lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_29_4ed294c84c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKBDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

