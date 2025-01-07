module 0xa5b6c9e78500e1f01d26732c26612366c9d501b974a701348389237541e91dd1::jams {
    struct JAMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMS>(arg0, 6, b"JAMS", b"SUI Jam", b"SUI Jam - Spreading into the SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MGA_LOGO_2_5966874bed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

