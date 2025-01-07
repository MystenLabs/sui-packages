module 0x44894aae4340a08982a9a21a7073b9b792dcf0ad967f3e67a7541b3ea40f41d8::suimen {
    struct SUIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEN>(arg0, 6, b"SUIMEN", b"SUIMEN Token", b"Cumming soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIMEN_Token_1918467da7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

