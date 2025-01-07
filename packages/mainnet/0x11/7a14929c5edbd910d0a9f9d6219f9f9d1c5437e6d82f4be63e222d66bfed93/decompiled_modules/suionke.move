module 0x117a14929c5edbd910d0a9f9d6219f9f9d1c5437e6d82f4be63e222d66bfed93::suionke {
    struct SUIONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONKE>(arg0, 6, b"SUIONKE", b"SONKE ON SUI", b"Welcome to SUIONKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snapedit_1728933209732_2_c72822c5db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

