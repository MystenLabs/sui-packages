module 0x6c6238d76bceed599cc4643c3604b669e02023b45bd1613396bc5d6c1c038148::tara {
    struct TARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARA>(arg0, 6, b"TARA", b"Fluffy Nerfs", x"537765657420245441524120697320746865206d6f737420737765657465737420637574657374207468696e6720696e2074686520776f726c642e205368652077696c6c206d656c742065766572796f6e65732068656172742e200a5368652069732066616d6f7573206d656f772077686f20686173203238356b20666f6c6c6f77657273206f6e20696e7374616772616d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tara_299742e339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

