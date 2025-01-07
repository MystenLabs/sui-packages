module 0xa643ee5d1ca9b50ee8c8258a3912c19b15ee4665b42793ac1ad43fe2937a3b48::ftx {
    struct FTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTX>(arg0, 6, b"FTX", b"FTX6900", x"46545836393030204953204241434b20494e20414354494f4e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Xkkg94ocv_XFZ_37g8621it_E_Qwvp_Fuuonx_Ne_Q1_Q_Jk_X_Exd_d9941f0fb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

