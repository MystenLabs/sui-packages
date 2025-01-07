module 0xae592c7f7a96ab4c8ac0d9f03b88d1116b79b33e7afb963978e5b97b8c0b7e47::sgreg {
    struct SGREG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGREG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGREG>(arg0, 6, b"SGREG", b"SUIGREG", b"Your childhood best friend is now back on your side.. ON CHAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_78_f78cd0cb9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGREG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGREG>>(v1);
    }

    // decompiled from Move bytecode v6
}

