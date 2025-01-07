module 0xd790c2243749daf0583d469953db9b75762c6219f27adf4b129f0a60b0059d75::fwh {
    struct FWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWH>(arg0, 6, b"FWH", b"Frog Wif Hat", b"FWH meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Na_X6_R_Ku14z4f_K1_X5ddxc2q_B2_P8mwifr_Z2_Uo_P53wsj4_Az_e7b2fd5627.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

