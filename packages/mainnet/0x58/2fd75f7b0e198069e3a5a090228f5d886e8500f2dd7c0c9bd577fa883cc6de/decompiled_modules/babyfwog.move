module 0x582fd75f7b0e198069e3a5a090228f5d886e8500f2dd7c0c9bd577fa883cc6de::babyfwog {
    struct BABYFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYFWOG>(arg0, 6, b"BABYFWOG", b"Baby Fwog", x"4a7573742061206375746520426162792046776f672e20536f6369616c7320636f6d696e6720736f6f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T9b_Jg_T5py9_Ar91xr5_MX_1_Sv43_Dtr_Yscjbki_SFME_8xz_S74_0b137680a0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

