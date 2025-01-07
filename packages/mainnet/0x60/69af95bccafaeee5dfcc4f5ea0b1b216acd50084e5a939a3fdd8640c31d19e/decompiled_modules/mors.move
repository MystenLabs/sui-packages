module 0x6069af95bccafaeee5dfcc4f5ea0b1b216acd50084e5a939a3fdd8640c31d19e::mors {
    struct MORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORS>(arg0, 6, b"MORS", b"MORS SUI", b"Mors is Walrus, silent and brave. Now ready to roar, from the depths to the light, Together we rise, with united Mors might", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M0_GZIS_J_400x400_963bc566b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORS>>(v1);
    }

    // decompiled from Move bytecode v6
}

