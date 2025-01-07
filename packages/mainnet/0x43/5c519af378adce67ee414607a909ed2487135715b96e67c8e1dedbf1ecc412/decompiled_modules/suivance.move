module 0x435c519af378adce67ee414607a909ed2487135715b96e67c8e1dedbf1ecc412::suivance {
    struct SUIVANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVANCE>(arg0, 6, b"SUIVANCE", b"Sui Vance", b"Vance has landed on SUI https://x.com/jdvance?lang=en", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rcx_APKU_7_M_Iam_3c6487f2c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

