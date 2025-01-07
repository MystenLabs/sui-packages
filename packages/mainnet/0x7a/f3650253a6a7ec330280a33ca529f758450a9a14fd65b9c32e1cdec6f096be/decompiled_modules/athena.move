module 0x7af3650253a6a7ec330280a33ca529f758450a9a14fd65b9c32e1cdec6f096be::athena {
    struct ATHENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATHENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATHENA>(arg0, 6, b"Athena", b"Athena AI", b"when the market cap reaches $69,158 all the liquidity from the bonding curve will be deposited into Raydium and burned. progression increases as the price goes up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pz_Nz_Xmnz5f_Em_Zgq_Swjxbk1_Jpo_H_Vmm_Rnfk2_DPFD_Usn_N_Lz_2aeaa6f8ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATHENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATHENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

