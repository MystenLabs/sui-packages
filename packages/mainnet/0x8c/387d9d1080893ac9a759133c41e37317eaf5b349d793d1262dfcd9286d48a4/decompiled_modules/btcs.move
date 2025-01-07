module 0x8c387d9d1080893ac9a759133c41e37317eaf5b349d793d1262dfcd9286d48a4::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCS>(arg0, 6, b"BTCS", b"Better Call SUI", x"53686f7274732063616e207375636b206d79206e7574730a5765276c6c20676f20686967686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4m8_N_Iitj_400x400_e74e8f9ebc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

