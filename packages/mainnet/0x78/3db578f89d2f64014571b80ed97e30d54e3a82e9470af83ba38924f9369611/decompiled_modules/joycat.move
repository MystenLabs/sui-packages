module 0x783db578f89d2f64014571b80ed97e30d54e3a82e9470af83ba38924f9369611::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 6, b"JOYCAT", b"JOYCAT ON SUI", b"Your own Mascot on SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_joycat_795ecc4fac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

