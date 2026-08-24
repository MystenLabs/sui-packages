module 0xea2d22031b64c4e5927ff3198cb9df6a1f52b53ff3602fd6094e088d6066f17::myoft {
    struct MYOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MYOFT>(arg0, 6, 0x1::string::utf8(b"Ram"), 0x1::string::utf8(b"2 Sticks of Ram"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYOFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MYOFT>>(0x2::coin_registry::finalize<MYOFT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

