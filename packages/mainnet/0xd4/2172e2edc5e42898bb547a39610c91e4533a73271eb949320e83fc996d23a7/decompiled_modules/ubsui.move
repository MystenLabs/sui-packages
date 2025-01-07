module 0xd42172e2edc5e42898bb547a39610c91e4533a73271eb949320e83fc996d23a7::ubsui {
    struct UBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBSUI>(arg0, 6, b"UBSUI", b"UMBREON SUI", b"The OG Umbreon Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_3_2_3ae97ff2f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

