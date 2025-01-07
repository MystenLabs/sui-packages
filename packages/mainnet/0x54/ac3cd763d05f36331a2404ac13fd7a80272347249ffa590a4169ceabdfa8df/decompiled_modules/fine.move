module 0x54ac3cd763d05f36331a2404ac13fd7a80272347249ffa590a4169ceabdfa8df::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"THIS IS FINE", b"I always got rugged on every meme coin that i buy, but this is fine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_fine_598425e7b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

