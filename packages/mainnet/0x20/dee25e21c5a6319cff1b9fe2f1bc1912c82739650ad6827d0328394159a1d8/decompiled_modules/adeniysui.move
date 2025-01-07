module 0x20dee25e21c5a6319cff1b9fe2f1bc1912c82739650ad6827d0328394159a1d8::adeniysui {
    struct ADENIYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYSUI>(arg0, 6, b"ADENIYSUI", b"Adeniyi Wif Hat", x"53756927732062657374202b2061206861742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_203806544_b489ee7832.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENIYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

