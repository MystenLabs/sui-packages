module 0xa7370f6ff72d6fef563543a6686e24f9f6797d291662b1babefea60bea8403c8::hood {
    struct HOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOD>(arg0, 6, b"HOOD", b"ROBINHOOD", b"ROBINHOOD ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7822_1622c49f65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

