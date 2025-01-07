module 0x5808029c9204a4ceb1c9f850a60b4c4304a6d1f9751da530b9af23d6821e858b::eggdolf {
    struct EGGDOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGDOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGDOLF>(arg0, 6, b"Eggdolf", b"Eggdolf Hitlur", x"46756e6e7920656767207720637574206c696b652061646f6c662068696c7465720a0a4a75737420666f722066756e2c206e6f20736f6369616c2c206669727374206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000107135_3373e3268f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGDOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGDOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

