module 0xa32c0be36a7d4d1adaedb75137e3bf10439499ad6c29bc9f23c58123c33d1100::villain {
    struct VILLAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILLAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILLAIN>(arg0, 6, b"Villain", b"Villain on sui", x"57656c636f6d6520746f2074686520776f726c64206f662056696c6c61696e7321204c65742773206372656174652074686520756c74696d61746520616374696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ta_o_nh_A_n_v_A_t_kha_ng_la_xanh_ba_ng_va_tranh_2_Copy_d46015ab50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILLAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VILLAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

