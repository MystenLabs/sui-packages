module 0x2c50ce598b1a23498aa5a1360f6c86a2c4ec783ebc15e1cb34be048f1c68bb6b::spelf {
    struct SPELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPELF>(arg0, 6, b"SPELF", b"SUIPELF", x"50455045202b20456c66203d205350454c460a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_77_bec62dd89c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

