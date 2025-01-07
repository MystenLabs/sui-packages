module 0x63eea17a01c9380cdfe16e721cdc165d052b5d17cf9a13d4eb71ae6eb51d1c7d::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 6, b"KITTY", b"Kitty Cat", b"Dive into an incredible adventure with the internets most iconic cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29855_219dea8a47_646460f387.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

