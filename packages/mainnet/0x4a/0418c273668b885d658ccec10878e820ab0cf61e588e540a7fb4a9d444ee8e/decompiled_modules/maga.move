module 0x4a0418c273668b885d658ccec10878e820ab0cf61e588e540a7fb4a9d444ee8e::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"MakeAltcoinGreat", b"Make altcoins great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2025_02_03_D_12_35_43_bc4fac8475.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

