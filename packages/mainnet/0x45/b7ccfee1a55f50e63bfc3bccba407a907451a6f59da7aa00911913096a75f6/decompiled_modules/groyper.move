module 0x45b7ccfee1a55f50e63bfc3bccba407a907451a6f59da7aa00911913096a75f6::groyper {
    struct GROYPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROYPER>(arg0, 6, b"GROYPER", b"GROYPER SUI", x"47726f79706572206c6f766520746f2074726f6c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_36_d53b061e17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROYPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROYPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

