module 0x867c0687d2369e1c1bffdfe783db3adc12111b0753b4e2e362235f2ef982616c::hood {
    struct HOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOD>(arg0, 6, b"HOOD", b"ROBINHOOD COIN", b"ROBINHOOD COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7822_646a0e9397.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

