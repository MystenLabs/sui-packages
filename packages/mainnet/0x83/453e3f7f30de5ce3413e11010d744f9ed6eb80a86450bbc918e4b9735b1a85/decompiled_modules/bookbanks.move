module 0x83453e3f7f30de5ce3413e11010d744f9ed6eb80a86450bbc918e4b9735b1a85::bookbanks {
    struct BOOKBANKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKBANKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKBANKS>(arg0, 6, b"BOOKBANKS", b"BOOK OF BANKS", x"74686520626573742062616e6b7320696e2074686520776f726c640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_10_A_s_17_09_45_1a9e46dd_18b87753b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKBANKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKBANKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

