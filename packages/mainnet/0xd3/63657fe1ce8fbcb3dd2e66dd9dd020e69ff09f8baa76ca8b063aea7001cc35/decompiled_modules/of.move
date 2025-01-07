module 0xd363657fe1ce8fbcb3dd2e66dd9dd020e69ff09f8baa76ca8b063aea7001cc35::of {
    struct OF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OF>(arg0, 6, b"OF", b"My Only Fans", b"Giving away free subscriptions to top 20 Holders at 20k market cap ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RN_Yp_SCD_3_Rj_J1rsk_RVCSC_8p_W4_V_Lng5_HG_9z2_GD_Mv_Bs_J4oy_a192843316.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OF>>(v1);
    }

    // decompiled from Move bytecode v6
}

