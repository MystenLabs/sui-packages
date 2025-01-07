module 0xdcf816e80e130feb71dd1c763752c675cb46e88bd494dab45c0669d9210499d1::mana {
    struct MANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANA>(arg0, 6, b"MANA", b"MANATEE SUI", b"MANATEE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_38_a7c5cb157e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

