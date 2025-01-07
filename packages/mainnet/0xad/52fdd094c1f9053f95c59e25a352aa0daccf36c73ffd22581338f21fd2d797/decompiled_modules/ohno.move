module 0xad52fdd094c1f9053f95c59e25a352aa0daccf36c73ffd22581338f21fd2d797::ohno {
    struct OHNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHNO>(arg0, 6, b"OhNO", b"Oh NO", x"4e6f20696e766573746f72730a4e6f20636f6c6c61626f726174696f6e730a4e6f2068797065200a4f68204e4f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_09_D_14_31_04_1e10a47da1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

