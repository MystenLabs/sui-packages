module 0xb96e8d12f8a4c7f6d66f8b31eff6f75076bd29c472847ebcb7663342bb7e65da::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"MEWING SNOWMAN", b"Sui Snow Chad is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Yhhe_S7_Jkm_D_Geh_Eaz1_G6_Bw4_Wjx7vx_UMQSB_Ljy_L45pump_7eff9c4272.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

