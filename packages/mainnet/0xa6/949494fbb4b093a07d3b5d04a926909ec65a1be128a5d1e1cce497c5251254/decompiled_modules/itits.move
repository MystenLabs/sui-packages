module 0xa6949494fbb4b093a07d3b5d04a926909ec65a1be128a5d1e1cce497c5251254::itits {
    struct ITITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITITS>(arg0, 6, b"ITITS", b"Ivanka Trump Private Photos", b"All tots all the time. Got lots of Ivanka tots :) some never seen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Kk_D_Yotx_Xw6mk1v_Wtzfp_Ce8g_GV_6w_Lsz_Kj1_Lueyo_Njqr_G_56112124ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

