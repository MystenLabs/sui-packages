module 0x48794a0627f6eee1653e498a0ad4e26c31cb904fc6ec3835ff9099fb9c32cd94::heaven {
    struct HEAVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAVEN>(arg0, 6, b"HEAVEN", b"HEAVENONSUI", b"$HEAVEN ON SUI OFFICIAL LAUNCH 10/10", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Yg_L5okk_E5exs_T_Lzebt5_Hmt_K9_Ay2_H_Mr53i8ubm_VC_2e_BR_9be6ead62e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEAVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

