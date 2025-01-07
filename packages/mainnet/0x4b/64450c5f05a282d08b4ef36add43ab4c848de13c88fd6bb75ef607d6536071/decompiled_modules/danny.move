module 0x4b64450c5f05a282d08b4ef36add43ab4c848de13c88fd6bb75ef607d6536071::danny {
    struct DANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANNY>(arg0, 6, b"DANNY", b"DANNY SUI", b"MONNEY FOR DANNY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RI_9cj_U76gl_U_Rh_XU_Mv_N_Nt7_Bu_OE_45330def0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

