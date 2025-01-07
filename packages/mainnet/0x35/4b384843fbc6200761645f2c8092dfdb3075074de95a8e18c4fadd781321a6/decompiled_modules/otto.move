module 0x354b384843fbc6200761645f2c8092dfdb3075074de95a8e18c4fadd781321a6::otto {
    struct OTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTO>(arg0, 6, b"OTTO", b"ottobot", x"566963746f727920616e642046756e206163686965766564207468726f75676820414920726f626f747320244f54544f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PM_5_Ubj_Cp81o_L_Wb_Tx_AV_Jh_US_Yz19opq_Up_Yfxnjpbr_Ur2_QY_355d12cdae.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

