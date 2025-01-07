module 0xa89e18c9e9c7496626b71e14de67dcca137f95ba5b5e9ed8b461fbac7d815983::lobo {
    struct LOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBO>(arg0, 6, b"LOBO", b"LOBOSUI", b"0xccec5ce0461e9a267651d2897db5f9253df3c0fe54a19200591660c3c9d0fcdb::lobo::LOBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_10_xxxffdff_4f0050d03d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

