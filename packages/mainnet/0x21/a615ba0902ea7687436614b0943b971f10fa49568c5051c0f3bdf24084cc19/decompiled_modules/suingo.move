module 0x21a615ba0902ea7687436614b0943b971f10fa49568c5051c0f3bdf24084cc19::suingo {
    struct SUINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINGO>(arg0, 6, b"SUINGO", b"Suingo", x"5768656e20796f752074727920746f206861766520612072656c6178696e6720686f6c696461792c2062757420796f757220696e6e6572207377696e676f206b69636b7320696e2e2e2e20f09f8cb4f09f9283", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Capture_d_ecran_2024_12_22_a_18_54_18_18dd9f46cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINGO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

