module 0x17a6ab7b47b1198cf7b359082e89ef509f30e9a25f8cdf19919e596d1e68ceb3::hugo {
    struct HUGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUGO>(arg0, 6, b"HUGO", b"Hugo Axolotl", b"Hugo is here to be cute as hell and fuck shit up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_09_19_26_a0bd98ed85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

