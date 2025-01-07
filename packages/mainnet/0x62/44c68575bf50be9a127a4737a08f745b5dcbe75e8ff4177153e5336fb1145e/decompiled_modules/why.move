module 0x6244c68575bf50be9a127a4737a08f745b5dcbe75e8ff4177153e5336fb1145e::why {
    struct WHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHY>(arg0, 6, b"WHY", b"WHY DID I SELL", b"WHY DID I SELL I SHOULD OF HELD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Trs_GB_5_Yi_Wd_Nme_BG_Bb_Fy_UNZ_9_Nz_Harz9_MT_6_Jie_Qj_At18nz_4cdbc29209.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

