module 0x77dc3a0c948850d39f0c582941dbed2e06d50c95d2b357663bfe3e1d4dfc2324::suipiens {
    struct SUIPIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIENS>(arg0, 6, b"SUIPIENS", b"Suipiens", b"OG Community on $Sui Ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Sx_W_Miq_T_400x400_d02795fb1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

