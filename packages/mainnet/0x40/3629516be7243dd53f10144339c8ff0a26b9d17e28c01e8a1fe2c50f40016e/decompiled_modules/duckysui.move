module 0x403629516be7243dd53f10144339c8ff0a26b9d17e28c01e8a1fe2c50f40016e::duckysui {
    struct DUCKYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKYSUI>(arg0, 6, b"DUCKYSUI", b"DUCKY DUCK", b"The secret fren of Pepe, Andy, Brett, and Landwolf | Part of Matt Furie's Boys Club legacy | Join us in the quacktastic world of $DUCKY | Just Duck it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86k_Ks6z_P_400x400_89cd424296.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

