module 0xd4bf4277c232c1f0b8339d17f1c6ff096cdc09a0179375d34ff99b576332ca3a::ntc {
    struct NTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTC>(arg0, 6, b"NTC", b"NETCOIN", b"Satoshi Nakamoto initially planned to name the token he created NTC (NETCOIN). Satoshi Nakamoto had many cats and dogs, but Bitcoin had only one original name, and it was forever written into the blockchain, which was $ NTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wt3h3b_Ya_Uij_G1_Zm1c_L1_QFD_1hes5ct7shi7_B6i_Nt_HP_5n_W_aa15575d36.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

