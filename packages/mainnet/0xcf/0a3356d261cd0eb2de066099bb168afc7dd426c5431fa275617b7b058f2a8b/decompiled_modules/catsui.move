module 0xcf0a3356d261cd0eb2de066099bb168afc7dd426c5431fa275617b7b058f2a8b::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 6, b"Catsui", b"catfamsui", x"5765206c6f7665202446434154204c696b6520796f752e2024464341542066616d696c7920616c6c20696e206f6e6520706c6163650a0a68747470733a2f2f742e6d652f63617466616d696c796d756c74636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031328_e14fb878da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

