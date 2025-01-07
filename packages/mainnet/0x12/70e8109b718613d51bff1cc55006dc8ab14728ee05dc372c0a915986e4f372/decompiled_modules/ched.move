module 0x1270e8109b718613d51bff1cc55006dc8ab14728ee05dc372c0a915986e4f372::ched {
    struct CHED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHED>(arg0, 6, b"CHED", b"Cheese Doge", b"Cheedy ruff ruff ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6251_0c311fb6b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHED>>(v1);
    }

    // decompiled from Move bytecode v6
}

