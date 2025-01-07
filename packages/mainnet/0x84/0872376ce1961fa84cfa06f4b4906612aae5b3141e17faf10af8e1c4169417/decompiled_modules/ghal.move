module 0x840872376ce1961fa84cfa06f4b4906612aae5b3141e17faf10af8e1c4169417::ghal {
    struct GHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHAL>(arg0, 6, b"GHAL", b"Ghost Halloween", b"Ghost Halloween $GHAL coming ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730980294548.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

