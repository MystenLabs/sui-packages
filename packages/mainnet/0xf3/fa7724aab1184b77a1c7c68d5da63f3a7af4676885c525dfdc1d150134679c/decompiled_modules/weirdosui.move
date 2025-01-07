module 0xf3fa7724aab1184b77a1c7c68d5da63f3a7af4676885c525dfdc1d150134679c::weirdosui {
    struct WEIRDOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRDOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRDOSUI>(arg0, 6, b"WEIRDOSUI", b"weirdo_sui", b"Uniting weirdos worldwide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_I1_G_Ho_TP_400x400_e77b7f51a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRDOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEIRDOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

