module 0x487a5bdd619bdc13232146b3aa06b3124159560db9fde80ecde9d8b1478ef1cf::scarlo {
    struct SCARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARLO>(arg0, 6, b"SCARLO", b"CARLO SUI", x"57484f2057414e545320544f20484156452041204c4954544c452046554e20544f4441593f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GN_Hu_k_F_Wg_AAL_Oo_A_3b7041beb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

