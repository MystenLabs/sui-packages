module 0xa80506e070aebfd433e7e54c6d936438cf0ff2e7195df2fb91fac193d089370c::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SUICAT", b"SUI CAT SUI CAT SUI CAT SUI CAT SUI CAT SUI CAT SUI CAT SUI CAT SUI CAT SUI CAT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9253ccb5f1937961d17e2dfbf2871d50_65d90d52cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

