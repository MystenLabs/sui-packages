module 0x6de052239c5e7105cafd9d3336e86e238bfde9d5a69869967db50f9253ac33b1::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 6, b"JEET", b"We All Hate Kaito", b"Kaito Is A Jeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kaito_prof_1a812defca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

