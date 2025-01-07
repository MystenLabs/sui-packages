module 0x5ce598c17103e16f2cf3885f00b78f0b3fd54fd4c681736c446e13d05436e801::furry {
    struct FURRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRY>(arg0, 6, b"FURRY", b"BLUE FURRY BY MATT FURIE", b"Meet FURRY by Matt Furie, the ultimate lovable dad with a heart as big as a warm hug. Furry is featured in Matt Furie's 'Mindviscosity'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3654_8477ec0b31.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

