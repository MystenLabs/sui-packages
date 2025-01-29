module 0x13d56b0c42abfac4b4bfb86645aea147f32d2518afb6f5e5053af8bbbafe8a60::dlm {
    struct DLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLM>(arg0, 6, b"DLM", b"Deep Language Model", b"Deep Language Model on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_102522_710_c3639d2173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

