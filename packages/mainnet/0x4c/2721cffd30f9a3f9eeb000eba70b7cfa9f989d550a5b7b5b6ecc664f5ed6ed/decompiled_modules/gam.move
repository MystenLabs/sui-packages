module 0x4c2721cffd30f9a3f9eeb000eba70b7cfa9f989d550a5b7b5b6ecc664f5ed6ed::gam {
    struct GAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAM>(arg0, 6, b"GAM", b"GOTHAM", b"Number One Memecoin on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784933724611.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

