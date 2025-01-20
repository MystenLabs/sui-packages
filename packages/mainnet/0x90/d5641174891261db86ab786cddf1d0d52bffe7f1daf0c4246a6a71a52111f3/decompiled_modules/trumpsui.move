module 0x90d5641174891261db86ab786cddf1d0d52bffe7f1daf0c4246a6a71a52111f3::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"TRUMP SUI", b"Just Trump token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo2_fecb3428e7_1c3542c2fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

