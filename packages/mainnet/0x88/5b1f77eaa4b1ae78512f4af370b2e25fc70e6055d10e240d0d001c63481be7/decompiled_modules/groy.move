module 0x885b1f77eaa4b1ae78512f4af370b2e25fc70e6055d10e240d0d001c63481be7::groy {
    struct GROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROY>(arg0, 6, b"GROY", b"GROYPER SUI", b"Smug #4Chan Toad  BestFriend of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_36_4f4b368b0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

