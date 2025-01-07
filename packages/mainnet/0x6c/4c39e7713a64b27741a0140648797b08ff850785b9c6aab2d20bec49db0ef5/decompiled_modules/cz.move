module 0x6c4c39e7713a64b27741a0140648797b08ff850785b9c6aab2d20bec49db0ef5::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ>(arg0, 6, b"CZ", b"CZ-OUT", b"CZ is coming out soon. You cant be bearish here bro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024091814403916_64616eec26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

