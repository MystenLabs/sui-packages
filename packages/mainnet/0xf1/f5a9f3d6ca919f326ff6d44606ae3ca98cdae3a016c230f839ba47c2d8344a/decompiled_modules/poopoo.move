module 0xf1f5a9f3d6ca919f326ff6d44606ae3ca98cdae3a016c230f839ba47c2d8344a::poopoo {
    struct POOPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPOO>(arg0, 6, b"POOPOO", b"POOPOO ON SUI", b"The fusion of PEPE and Winnie the Pooh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_21_87f8beca97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

