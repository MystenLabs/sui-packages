module 0xc51f003c1b0a1f84c1d3b8953ab934a8747ec22d6b72a1ebd201a63ffc448637::dpm {
    struct DPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPM>(arg0, 6, b"DPM", b"DogPopMeme", b"DogPopMeme (DPM) is a viral meme coin on Sui, blending Dogwifhat, Popcat, and Book of Meme. Fast, low-cost, and community-driven, it offers fun and profit potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Trrs_ZL_1_Ms3_T7_Jgc_Gv_Qnk2_A71u_K_Dk_Rx_Dk_EL_Kw8_Haheuem_8bdb11ae5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

