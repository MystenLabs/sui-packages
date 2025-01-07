module 0x8900697ef9fc74a996ecdc6aa3cc32598f9e09e00fc4d7f3428b3ef9c8a50d89::bibi {
    struct BIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBI>(arg0, 6, b"BIBI", b"BIBI SUI", b"BIBI ON Sui OCEAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_8_b6086850c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

