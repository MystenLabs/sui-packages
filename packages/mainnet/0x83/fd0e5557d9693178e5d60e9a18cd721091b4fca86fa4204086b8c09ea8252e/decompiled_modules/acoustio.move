module 0x83fd0e5557d9693178e5d60e9a18cd721091b4fca86fa4204086b8c09ea8252e::acoustio {
    struct ACOUSTIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACOUSTIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACOUSTIO>(arg0, 6, b"ACOUSTIO", b"Acoustio", b"Acoustio is a memecoin forged in the wild heart of the Sui blockchain. It has no roadmap, no promises, and no expectation of financial return. Its not here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000077732_7fbb632ad3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACOUSTIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACOUSTIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

