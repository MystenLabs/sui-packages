module 0x88861de28e84718bf6877584309b47d4c0a2b4fd932a2a9a05c7012508ed0bd4::suipi {
    struct SUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPI>(arg0, 6, b"SUIPI", b"SUIPIDERMAN", b"Suipiderman is a parody Spider-Man is a superhero in American comic books published by Marvel Comics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipiderman_d8108ef410.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

