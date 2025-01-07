module 0x58c9b58363853380a3c6bce34f9fd74b7bb0d6888d7f9f7a5b2e59d113d81233::n69420 {
    struct N69420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N69420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N69420>(arg0, 6, b"N69420", b"69420", b"Nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_3302152de0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N69420>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<N69420>>(v1);
    }

    // decompiled from Move bytecode v6
}

