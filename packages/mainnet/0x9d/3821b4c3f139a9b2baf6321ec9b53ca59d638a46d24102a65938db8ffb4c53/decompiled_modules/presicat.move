module 0x9d3821b4c3f139a9b2baf6321ec9b53ca59d638a46d24102a65938db8ffb4c53::presicat {
    struct PRESICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESICAT>(arg0, 6, b"PRESICAT", b"Presicat", b"$PRESICAT for 47th President! #MACA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmad_Rd_Wv_B_Ti_Txcri4_N9ogb3_Ejm_P7fi_Pu_Gmm_Ma2q_K_Ge7bp_X_d04cac6f49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRESICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

