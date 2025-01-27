module 0x9a8ba45b82ad442f3859c41857eae2cabc3d024e3235e768cbd778333f396fb6::fafo {
    struct FAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FAFO>(arg0, 6, b"FAFO", b"FAFO by SuiAI", x"f09f9aa820425245414b494e473a205472756d70206a75737420706f73746564207468697320746f2054727574682e20e2809c4641464f21e2809d20f09f988220f09f988220f09f9882", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gi_Po8_Z_Na_AAAY_Ony_3d90a84803.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAFO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

