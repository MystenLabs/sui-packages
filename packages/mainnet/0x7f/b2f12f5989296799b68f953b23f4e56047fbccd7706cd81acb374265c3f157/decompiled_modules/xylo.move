module 0x7fb2f12f5989296799b68f953b23f4e56047fbccd7706cd81acb374265c3f157::xylo {
    struct XYLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYLO>(arg0, 6, b"XYLO", b"XYLO The Robot", x"58796c6f2069736e74206a757374206120636f696e3b206865732061207265766f6c7574696f6e61727920726f626f742c2070726f6772616d6d656420746f206c6561642074686520537569206e6574776f726b20746f20646f6d696e6174652074686520646563656e7472616c697a656420776f726c642e20486573206865726520746f20696e7370697265206120636f6d6d756e697479206f6620726562656c732c2063726561746f72732c20616e6420766973696f6e617269657320726561647920746f206f7665727468726f77206f6c642073797374656d732e204a6f696e2058796c6f7320726562656c6c696f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsddd_df5e229cc1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XYLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

