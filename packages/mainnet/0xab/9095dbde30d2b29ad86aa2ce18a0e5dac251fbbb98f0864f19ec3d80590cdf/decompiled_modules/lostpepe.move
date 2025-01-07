module 0xab9095dbde30d2b29ad86aa2ce18a0e5dac251fbbb98f0864f19ec3d80590cdf::lostpepe {
    struct LOSTPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSTPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSTPEPE>(arg0, 6, b"LOSTPEPE", b"LostPepe", x"4c6f7374506570652069732061206d656d6520636f696e20696e737069726564206279207468652066616d6f75732050657065207468652046726f672c20726570726573656e74696e6720746865206a6f75726e6579206f66206265696e67206c6f737420696e2074686520766173742063727970746f206a756e676c650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P6_RJJ_6_LB_Kmirxmss_NMXM_Wk_Vk_SC_1s_BMLRQ_9_Kz9hjdnbdq_c4af99dbfc.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSTPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOSTPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

