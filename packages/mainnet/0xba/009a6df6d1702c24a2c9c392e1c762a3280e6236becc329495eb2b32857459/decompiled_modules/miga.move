module 0xba009a6df6d1702c24a2c9c392e1c762a3280e6236becc329495eb2b32857459::miga {
    struct MIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGA>(arg0, 6, b"MIGA", b"Make Ingest Great Again", x"4d616b6520496e6765737420477265617420416761696e20697320616e20696e6974696174697665206c656420627920446f6e616c64205472756d7020746f207265766f6c7574696f6e697a652074686520666f6f6420696e647573747279207573696e6720535549277320626c6f636b636861696e20746563686e6f6c6f67792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tuasd123123lo_1_eb59bbb84a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

