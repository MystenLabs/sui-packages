module 0x19b01b60d7f06092271450c2b43381f3e97d388ae6775521b448bedeb518c11c::astroai {
    struct ASTROAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTROAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASTROAI>(arg0, 6, b"ASTROAI", b"ASTROAI by SuiAI", b"AstroAI is a successful experiment of AI technologies. Join our community to talk with Astro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Y_Asw_DA_Sk_400x400_7e5ecbe820.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASTROAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTROAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

