module 0x19cce7c98d34edc1c2f62ca728484949fd2dec112c98dbf2b59d355164a219e::unsloth {
    struct UNSLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNSLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNSLOTH>(arg0, 6, b"UNSLOTH", b"Unsloth AI", b"Open source LLM fine-tuning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZUA_Ak_FX_5f6_BVXU_3_Py_X9i_Xsq_X4_Zp_SEU_Wqzv_Ug_DX_Lz_WVKN_79f611e8b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNSLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNSLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

