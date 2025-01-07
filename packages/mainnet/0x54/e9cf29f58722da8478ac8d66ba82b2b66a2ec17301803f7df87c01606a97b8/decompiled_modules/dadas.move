module 0x54e9cf29f58722da8478ac8d66ba82b2b66a2ec17301803f7df87c01606a97b8::dadas {
    struct DADAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADAS>(arg0, 6, b"Dadas", b"sdaaaa", b"dsadsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5d_R_Pjft_E_Fq_SW_6_Z_Ll_8bd39d1b37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

