module 0x5a85e0c8cdfd2908a11a5a64ec747d75ff202b63543f2f46d8c606fc716fd6bc::rwa {
    struct RWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWA>(arg0, 6, b"RWA", b"Kumo_TheCat", b"Subtle foreshadowing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Cyh88y_J_400x400_5953d91da9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

