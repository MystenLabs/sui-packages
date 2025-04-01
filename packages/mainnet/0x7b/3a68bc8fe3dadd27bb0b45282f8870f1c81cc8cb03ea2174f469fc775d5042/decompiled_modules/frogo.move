module 0x7b3a68bc8fe3dadd27bb0b45282f8870f1c81cc8cb03ea2174f469fc775d5042::frogo {
    struct FROGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGO>(arg0, 6, b"FROGO", b"Frogo", b"FrogoCoin ($FROG) is a memecoin with style! Inspired by the sophisticated, top-hat-wearing frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053026_094705288a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

