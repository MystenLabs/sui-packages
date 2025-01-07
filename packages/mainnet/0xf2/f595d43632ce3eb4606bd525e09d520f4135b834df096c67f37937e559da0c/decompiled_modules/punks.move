module 0xf2f595d43632ce3eb4606bd525e09d520f4135b834df096c67f37937e559da0c::punks {
    struct PUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKS>(arg0, 6, b"Punks", b"SuiPunks", x"202453756920706f7765726564206279202450554e4b20746f6b656e2c2063726561746564206279200a405375696c6c696f6e616972650a6d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/punk_faa6232d9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

