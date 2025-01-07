module 0xb85dff04ac630a874e64c4b722dbc92480bc2ed8a577596ceefe66f352aeb1bc::bonita {
    struct BONITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONITA>(arg0, 6, b"BONITA", b"Bonita on SUI", x"4120726564656d7074696f6e2073746f72792e2e2e207468652066697273742066656d616c6520646f67206f6e205355492e0a57652077696c6c2072656465656d206865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Nif_LHVP_400x400_a94ff56712.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

