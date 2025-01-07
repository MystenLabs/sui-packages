module 0xa1fdc3a28f07730d528bf1815cfe65e1968597346bc089448d16437bae74f29::riko {
    struct RIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIKO>(arg0, 6, b"RIKO", b"Riko the Otter", b"Everyone's favorite SUI Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zif_Qd_Xw_Ac_DP_6_P_5d3cdee9aa.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

