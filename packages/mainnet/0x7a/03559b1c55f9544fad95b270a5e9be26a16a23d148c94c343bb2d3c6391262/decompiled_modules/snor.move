module 0x7a03559b1c55f9544fad95b270a5e9be26a16a23d148c94c343bb2d3c6391262::snor {
    struct SNOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOR>(arg0, 6, b"SNOR", b"Sui Snor", b"Just a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011605_8e9c698bfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

