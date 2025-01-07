module 0x8aa9f2c74385801701916fd19ae1b3dec8222f4732e26f7cdc1de13b8a2a0ade::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 6, b"SODA", b"$SODA SUI", b"Drawing inspiration from Yoda to form $SODA on Sui, but as a kindred spirit in the chaotic dance of the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_16_e694946866.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

