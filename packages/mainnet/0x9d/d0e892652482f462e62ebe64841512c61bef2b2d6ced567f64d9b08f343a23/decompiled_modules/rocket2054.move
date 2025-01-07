module 0x9dd0e892652482f462e62ebe64841512c61bef2b2d6ced567f64d9b08f343a23::rocket2054 {
    struct ROCKET2054 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET2054, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET2054>(arg0, 6, b"ROCKET2054", b"ELON CATCHING ROCKETS (2054)", b"Beeple's Tweet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_0n0_RH_Wc_AYY_8ei_3427f4969a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET2054>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKET2054>>(v1);
    }

    // decompiled from Move bytecode v6
}

