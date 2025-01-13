module 0xdfe3018bd40efb2f36fdb40f3f135ff8b3ab510d91b6e8b82d88764d2a39762d::cpred {
    struct CPRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPRED>(arg0, 6, b"CPred", b"CyberPredator on sui", b"Welcome to the CPred community. Let's make great things together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ta_o_hinh_nh_A_n_va_t_kinh_da_1_9270d54759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

