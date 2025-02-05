module 0x96fbaeb87cd03cd9e2664fdf2643f535208ce8b3e995ce6e4f27a8e2e0547d77::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"Anon Ai", x"446563656e7472616c697a6564204149204672616d65776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/anon_7c3d0e29c0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

