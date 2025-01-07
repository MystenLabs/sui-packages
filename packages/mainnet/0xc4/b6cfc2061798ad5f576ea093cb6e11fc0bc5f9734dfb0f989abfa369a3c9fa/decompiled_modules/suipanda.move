module 0xc4b6cfc2061798ad5f576ea093cb6e11fc0bc5f9734dfb0f989abfa369a3c9fa::suipanda {
    struct SUIPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANDA>(arg0, 6, b"SUIPANDA", b"SUI PANDA", b"PANDA on SUI Wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Q_Aa_S5_Fl_400x400_e7273e040a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

