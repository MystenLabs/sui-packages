module 0xf7e0c8db263152154dd75e4a5c64f1213e0059dbf10610ac70d21d5192845fe3::kaat {
    struct KAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAAT>(arg0, 6, b"KAAT", b"Kaat Boot", x"48692069276d204b4141542e0a486f6c6420616e64204561726e2e0a57652061726520612067616d65206368616e67657220696e206d656d6520636f696e20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_LV_1_Y_Sa_N_Esdaivq6_e545f0e153.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

