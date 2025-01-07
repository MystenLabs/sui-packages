module 0x72769a4b6072b45adb95c8117eeb24cc3e84f5f0d724371a19574844bf27d0c6::transform {
    struct TRANSFORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRANSFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRANSFORM>(arg0, 6, b"TRANSFORM", b"Transform", x"7765206d757374207472616e73666f726d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rv_Xw_Ddby8q_U_Ke_LUV_232xs_UET_Vg8hjsctqk_PFSNCAC_28_D_34efc7f75c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRANSFORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRANSFORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

