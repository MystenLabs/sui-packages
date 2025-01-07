module 0x7a82697c34cf8bf214d3c237006ee0eedf8e89af4171baad0df93b7fcbf69466::ched {
    struct CHED has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHED>(arg0, 6, b"CHED", b"Cheese Doge", b"Cheesy ruff ruff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6251_3f85906bc8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHED>>(v1);
    }

    // decompiled from Move bytecode v6
}

