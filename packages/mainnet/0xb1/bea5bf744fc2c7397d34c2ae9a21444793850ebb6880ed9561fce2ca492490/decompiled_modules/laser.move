module 0xb1bea5bf744fc2c7397d34c2ae9a21444793850ebb6880ed9561fce2ca492490::laser {
    struct LASER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASER>(arg0, 6, b"Laser", b"Laser Eyes", b"Laser Eyes on Movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zi_M_Rps_XQA_0_T_hg_a87c561747.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASER>>(v1);
    }

    // decompiled from Move bytecode v6
}

