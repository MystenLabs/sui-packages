module 0x9d5c6fd69459a2aaf0445a61e5a2a6a5a22eb167c159418ce1cf93734bd42274::dchita {
    struct DCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCHITA>(arg0, 6, b"DCHITA", b"Devil Pochita", x"506f63686974612069732074686520746974756c6172206f76657261726368696e672070726f7461676f6e697374206f662074686520436861696e736177204d616e206d616e676120616e6420616e696d65207365726965732e2048652069732074686520436861696e73617720446576696c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z24_FKF_6_X_400x400_c1c99b5924.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

