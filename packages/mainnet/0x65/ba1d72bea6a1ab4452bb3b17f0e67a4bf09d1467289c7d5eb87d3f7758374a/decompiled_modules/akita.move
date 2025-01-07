module 0x65ba1d72bea6a1ab4452bb3b17f0e67a4bf09d1467289c7d5eb87d3f7758374a::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", b"AKITA on SUI | Launch Movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gcmx64aa4_A_Ag_F_j_6ecc4d8803.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

