module 0xd1f2f859df4b32053b99f19deaba23d6c4a79e2c51b6d19c4eafd1788337ded4::spi {
    struct SPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPI>(arg0, 6, b"SPI", b"Wanna be part of your symphony", b"I just wanna be part of your symphony", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SB_Ra_PB_Scu_Fum8y_C_Pfg_Nf_Q1bs_Zrq3_Dbh_SZC_4_Md_H1d_K_Tpg_1_76e88872c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

