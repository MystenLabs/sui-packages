module 0xdd4cd42e7d9204a03901f5247e12cf34312bbff3d7d8afdf8a485f975c39d987::boggs {
    struct BOGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGGS>(arg0, 6, b"BOGGS", b"The Land Of Boggs", b"https://www.tiktok.com/@thelandofboggs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ez_RYDQV_9r_NMP_Lw_Bsspicd_Nm_QN_Lm_Pe1zx_W21_Rw_Dh7pump_c40a388d85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

