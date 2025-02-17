module 0xb2ae595f35630857e18326489b1e4a74d215a6a968d51ee584d284887936e219::piai {
    struct PIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIAI>(arg0, 6, b"PiAI", b"Pi Network AI", x"2450694149202043727970746f63757272656e637920666f722065766572796461792070656f706c65206675656c696e672074686520776f726c6473206d6f737420696e636c757369766520706565722d746f2d706565722065636f6e6f6d792e200a405069436f72655465616d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B7_NPU_Gvx_C8_BUF_5a8_Bdxur_B_Nx_Cj_V3_Hwy_N6_Da_Rivtq_N_Aj_B_4de5854a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

