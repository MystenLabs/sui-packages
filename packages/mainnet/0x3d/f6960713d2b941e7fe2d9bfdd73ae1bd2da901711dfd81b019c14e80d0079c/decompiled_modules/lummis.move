module 0x3df6960713d2b941e7fe2d9bfdd73ae1bd2da901711dfd81b019c14e80d0079c::lummis {
    struct LUMMIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMMIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMMIS>(arg0, 6, b"LUMMIS", b"Senator Cynthia Lummis", x"54686520667574757265206973204272696768742e2057652061726520676f696e6720746f206275696c6420612073747261746567696320424954434f494e20524553455256450a68747470733a2f2f782e636f6d2f53656e4c756d6d69732f7374617475732f31383534323038333733373430343538343332", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_LUMMIS_2_c2d644943a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMMIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMMIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

