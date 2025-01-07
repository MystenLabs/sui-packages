module 0x9ce772dfc074e529ff2a2684725975253e66456111ef3d341c60ce7464f73041::harambai {
    struct HARAMBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAMBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARAMBAI>(arg0, 6, b"HARAMBAI", b"HARAMBAI ON SUI", x"692764207374696c6c2077616c6b20616d6f6e6720796f75206966206974207761736e277420666f722074686174206d6564646c696e67206b69642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xxg_B_Mongtatx6h_L7_Bju_U_Dqvy_Swaiw_Qx_Bzvwq2ti_L_Sf_Hw_ad72b33fed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARAMBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

