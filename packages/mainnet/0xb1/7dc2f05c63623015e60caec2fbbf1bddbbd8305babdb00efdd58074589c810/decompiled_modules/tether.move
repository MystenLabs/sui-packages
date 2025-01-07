module 0xb17dc2f05c63623015e60caec2fbbf1bddbbd8305babdb00efdd58074589c810::tether {
    struct TETHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETHER>(arg0, 6, b"TETHER", b"TetherBear", b"women and children have inspired the creation of TETHERBEAR ON SUI this will make children even happier when they experience our utility,this tether is ready to thrive among the top sui trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0012_a785b88a48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

