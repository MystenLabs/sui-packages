module 0x843b0c03bf3e321a89ee2e9737cf2e36fdf5d655487b4a58f80c4adda7fb17b8::brah {
    struct BRAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAH>(arg0, 6, b"BRAH", b"BRAH SUPPS INTL.", x"4352454154494f4e204259204c49464520504f5745520a0a4c494d49544c45535320204f462053554e20504f574552202043484541500a0a425241482057415920554e4c494d49544544", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_C_Bm8_B8uo_CUZ_Wjs9n32_B_Ny4z6_Lj_Gj4et_BH_2_X48_JW_Vhzf_8d4fdb5e43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

