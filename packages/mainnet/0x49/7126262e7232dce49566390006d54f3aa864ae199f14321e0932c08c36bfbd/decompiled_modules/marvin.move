module 0x497126262e7232dce49566390006d54f3aa864ae199f14321e0932c08c36bfbd::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin INU", b"Meet $MARVIN, Elon's little pup Marvin on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e5ok_S4_GZC_Zu_Tpqn_Mgex3b_L_Jfd_Q_Yca3_Ao_L_Yc36_PS_3b4_U_c7e30387ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

