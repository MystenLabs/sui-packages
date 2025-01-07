module 0x8500e76155cc80ae4563e4ffd0be4ac0b741f9e4d8b209f47146020c0a8af934::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 6, b"SNEIRO", b"NEIRO SUI", b"IM NEIRO ON SUI CHAIN. CHECK IT OUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_85_37ff168012.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

