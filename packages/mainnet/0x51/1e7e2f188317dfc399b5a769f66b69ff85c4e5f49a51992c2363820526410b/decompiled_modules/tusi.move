module 0x511e7e2f188317dfc399b5a769f66b69ff85c4e5f49a51992c2363820526410b::tusi {
    struct TUSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSI>(arg0, 6, b"TUSI", b"TUSKO SUi", b"Tusko sui tusi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29ctl_V1_F_Jo_TN_Ku3_C_Ux128lpp_Jpw_0f26552e33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

