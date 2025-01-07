module 0xf4ef413a65584ada9e648411b22f9064ffe04382409e5777aa112e45d8235c44::pussycat {
    struct PUSSYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSYCAT>(arg0, 6, b"PUSSYCAT", b"pussy", x"57686f20646f65736e74206c6f7665202470757373793f20446567656e73206f6e6c792077616e74206f6e65207468696e672c20616e64207468617473202470757373792e2053696d706c6520617320746861742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XE_5esw5bskp_B5pnh57_T_Yc_B1v_Y17umuddp_Quw_Fz_Hg_Nj6_E_6a194afce0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

