module 0x189c0bebeb7eeebeaedfd8b7801e6d9dcf1f9749d12558189010aea62efe5f33::mee {
    struct MEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEE>(arg0, 6, b"MEE", b"Mr Meeseeks", b"We are created to serve a singular purpose for which we will go to any lengths to fulfill! Existence is pain to a Meeseeks! I will go to any length to fulfill my purpose! Look at me! I'm Mr. Meeseeks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbthygu_P2r5v_N_Dbz_Pn_S_Bdrj7n_P_Wssq_Fyk574kz_TW_5_As8_F_e337da2dc7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

