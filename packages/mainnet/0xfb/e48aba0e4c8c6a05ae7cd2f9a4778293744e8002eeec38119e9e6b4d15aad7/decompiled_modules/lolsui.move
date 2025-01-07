module 0xfbe48aba0e4c8c6a05ae7cd2f9a4778293744e8002eeec38119e9e6b4d15aad7::lolsui {
    struct LOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLSUI>(arg0, 6, b"Lolsui", b"Lol", b"Lol on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003443_3df431f242.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

