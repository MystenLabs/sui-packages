module 0x44a227010545a72f53b4a11c6debd0bc203b6624c053188961a5a91a0fe8630c::rapcat {
    struct RAPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPCAT>(arg0, 6, b"RAPCAT", b"Rapcatcoin", b"Rapcat the cat that raps on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TG_4zdr_K_Pg_Vf_BSC_Ft6s3tsz_Cd_W8k2tmmpa_W76pcnf_Zbci_1_adf26feca7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

