module 0x4562b67d21da084fcecdee4a0af9c944b75e9fb2c90a519ff7e4f9ed3193876c::sana {
    struct SANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANA>(arg0, 6, b"SANA", b"Smiling Angel Neophocaena Asiaeorientalis", b"Yangtze finless porpoise - \"Smiling Angel\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zd_X1_ASXYA_Aa7_Va_cba5218aef.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

