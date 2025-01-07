module 0x9a9dde37fafbac1b90ba348d00f99525df7b1c9a8f415337d8be530ecc241087::usui {
    struct USUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUI>(arg0, 6, b"USUI", b"Umbre On  Sui", x"47657420696e206f6e207769746820556d62726520616e642062652070617274206f6620746865204f4720556d627265206f6e20537569207265766f6c7574696f6e2120200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_3_2_7563a39d18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

