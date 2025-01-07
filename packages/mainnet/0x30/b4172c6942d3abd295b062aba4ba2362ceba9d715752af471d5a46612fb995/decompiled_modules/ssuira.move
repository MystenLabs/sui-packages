module 0x30b4172c6942d3abd295b062aba4ba2362ceba9d715752af471d5a46612fb995::ssuira {
    struct SSUIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUIRA>(arg0, 6, b"SSUIRA", b"SUIRA ON SUI", b"one morning, Suira woke up with a mission to provide children with smiles all around the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_66_efaa7045f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

