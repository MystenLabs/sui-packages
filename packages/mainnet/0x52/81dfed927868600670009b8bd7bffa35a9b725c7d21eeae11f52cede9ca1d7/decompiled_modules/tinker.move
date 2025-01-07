module 0x5281dfed927868600670009b8bd7bffa35a9b725c7d21eeae11f52cede9ca1d7::tinker {
    struct TINKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINKER>(arg0, 6, b"TINKER", b"Tinkerbell", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Firefly_e_e_i_e_i_i_e_i_i_i_i_e_i_i_white_background_26276_91aae966c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

