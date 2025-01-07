module 0x8ae91189c749170a98d8c870feeb53cdbc320233123197d521c1d8570bb941d8::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 6, b"DOLPHIN", b"RichPinkDolphin", x"496e74726f647563696e67205269636850696e6b446f6c7068696e3a205468652053706c617368792043727970746f20436173696e6f20436f696e2120204d616b652077617665732020616e642077696e20626967202077697468205269636850696e6b446f6c7068696e21205768657468657220796f75726520726964696e6720746865206a61636b706f74207469646520206f72206a75737420686176696e672066756e202074686973206d656d6520636f696e206272696e67732074686520746872696c6c206f662074686520636173696e6f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOLPHIN_TUH_4np_4ql_Dlc_R_Ni_U1_T_f73e501133.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

