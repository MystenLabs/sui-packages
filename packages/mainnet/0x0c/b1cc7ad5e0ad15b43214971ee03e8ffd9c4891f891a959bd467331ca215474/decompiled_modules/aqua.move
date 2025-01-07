module 0xcb1cc7ad5e0ad15b43214971ee03e8ffd9c4891f891a959bd467331ca215474::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"Aqua", b"Where chaos meets crypto in a delightful, blue droplet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000115072_26bd379187.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

