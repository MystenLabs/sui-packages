module 0x13764983e19aebbaa982abead20f440930ce581e65791c4a82694c7bbad31ef2::siong {
    struct SIONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIONG>(arg0, 6, b"SIONG", b"Siong", b"cofounder of Jupiter Exchange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gi_J6_Ki_C_Wg_AAMQ_5a_7f19b5323c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

