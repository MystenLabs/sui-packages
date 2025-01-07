module 0x303995104f469c9bbfc9dec10d44811afbd6aedf948bbc14fe9fd7963fc20bd9::lmi {
    struct LMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMI>(arg0, 6, b"LMI", b"Lockheed Martin Inu", b"LockheedMartinInuONSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4c_EGA_8l6_400x400_662df90fbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

