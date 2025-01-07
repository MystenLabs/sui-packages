module 0x62417176182a2cd74c176a7f8b25eb00f52405a2a2fa6661dd681b3eb6b75524::sage {
    struct SAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGE>(arg0, 6, b"SAGE", b"Sage Universe", b"Sage Universe token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pnje_TH_1s_400x400_4d4f0ee38f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

