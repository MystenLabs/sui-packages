module 0x918fe6768ba246352b495972f9b4798ebf5eeb40bd9b6ac8a40b78a26279e3e6::kiroshai {
    struct KIROSHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIROSHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIROSHAI>(arg0, 6, b"KIROSHAI", b"Kiroshai", b"Introducing Kiroshai: the world's first AI-powered crypto screener designed to uncover hidden opportunities at lightning speed. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vd4_TG_Kr_X_Esqs_NQ_389_Sz_MPVRNT_Yviuf7k_M_Vmc48z_C3_VVC_c75b013a3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIROSHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIROSHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

