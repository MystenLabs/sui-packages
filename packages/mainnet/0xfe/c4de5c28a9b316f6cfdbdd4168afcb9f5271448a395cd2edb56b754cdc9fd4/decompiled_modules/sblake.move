module 0xfec4de5c28a9b316f6cfdbdd4168afcb9f5271448a395cd2edb56b754cdc9fd4::sblake {
    struct SBLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLAKE>(arg0, 6, b"SBLAKE", b"SUIBLAKE", x"557575757575682e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_41_d6fbc8b8a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

