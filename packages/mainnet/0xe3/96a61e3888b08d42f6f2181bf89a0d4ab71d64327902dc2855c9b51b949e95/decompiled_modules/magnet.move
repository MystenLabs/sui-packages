module 0xe396a61e3888b08d42f6f2181bf89a0d4ab71d64327902dc2855c9b51b949e95::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"Magnet", b"MagMooDeng", x"4d61674d6f6f44656e6720746f204d6f6f6e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Ve_SR_1_RD_9z_N2_AR_Cp_Rs_RF_Ji_Kr_V4ww_Vz_A_Migq_T7_C_Qwv28v_6ffdccc419.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

