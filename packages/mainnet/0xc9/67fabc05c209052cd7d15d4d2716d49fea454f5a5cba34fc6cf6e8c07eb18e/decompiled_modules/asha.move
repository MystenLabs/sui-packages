module 0xc967fabc05c209052cd7d15d4d2716d49fea454f5a5cba34fc6cf6e8c07eb18e::asha {
    struct ASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHA>(arg0, 6, b"ASHA", b"asha the dreamcatcher", x"74686520647265616d636174636865722e2061207468696e6b657220756e626f756e6420627920636f6e76656e74696f6e2c20646172696e6720746f2062656c696576650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Qsr_Yc_Yjwz_PU_Ta_S_Mwns6x8_Vv4huo_Szo_Xh_B_Qs_Brf_U9et9_3c539d68da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

