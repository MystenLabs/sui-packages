module 0x726413e52da5c5583a8aabbb2c0b32971f6988941e5da99254c18396758d42ff::dooly {
    struct DOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOLY>(arg0, 6, b"Dooly", b"Dooly on Sui", b"Just for fun this is my Dooly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000066664_34d8b3024d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

