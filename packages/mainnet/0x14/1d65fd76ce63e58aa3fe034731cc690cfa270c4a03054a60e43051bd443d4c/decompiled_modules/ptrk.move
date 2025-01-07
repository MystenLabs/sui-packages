module 0x141d65fd76ce63e58aa3fe034731cc690cfa270c4a03054a60e43051bd443d4c::ptrk {
    struct PTRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRK>(arg0, 6, b"PTRK", b"Patrick the king of the sui", b"Patrick the king of the sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_and_humorous_pop_art_graphic_design_2_7d16f95954.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

