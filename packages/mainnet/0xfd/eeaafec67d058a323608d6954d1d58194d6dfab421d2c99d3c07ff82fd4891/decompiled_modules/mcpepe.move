module 0xfdeeaafec67d058a323608d6954d1d58194d6dfab421d2c99d3c07ff82fd4891::mcpepe {
    struct MCPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCPEPE>(arg0, 6, b"MCPEPE", b"McPepe", x"46726f6d206b696e67206f662063727970746f63757272656e636965732c20746f206b696e67206f662068616d627572676572732e205768656e20796f75277665206c6f73742065766572797468696e672c207468657265277320616c77617973206120667279206c6566742120546865206c617374206d656d65636f696e20746f2062757920796f757273656c662061206c616d626f726768696e69206265666f72652065766572797468696e6720676f65732062656172206d61726b65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Peo_Eta6ni_G_Zv_WC_26_WMTB_Qph_So_PA_Nuc_A_Dr_Hc_Tm_G9_Eq_Q_Rp_bf58246949.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

