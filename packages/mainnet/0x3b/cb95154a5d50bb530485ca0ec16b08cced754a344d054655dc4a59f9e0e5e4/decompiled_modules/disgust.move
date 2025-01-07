module 0x3bcb95154a5d50bb530485ca0ec16b08cced754a344d054655dc4a59f9e0e5e4::disgust {
    struct DISGUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISGUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISGUST>(arg0, 6, b"Disgust", b"Disgust on sui", b"Broccoli belongs in the trash. So does your trash coin.  $DISGUST | Only fashionable investments. No cringe. Non-negotiable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1l5t_Jl_C_400x400_23676a5c10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISGUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DISGUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

