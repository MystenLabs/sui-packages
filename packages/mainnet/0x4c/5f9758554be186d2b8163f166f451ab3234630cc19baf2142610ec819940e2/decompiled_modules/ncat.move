module 0x4c5f9758554be186d2b8163f166f451ab3234630cc19baf2142610ec819940e2::ncat {
    struct NCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCAT>(arg0, 6, b"NCAT", b"NCAT on SUI", b"$NCAT on SUI  The First Neuracat Memecoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_N_Wb2_Tf_400x400_f86636b277.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

