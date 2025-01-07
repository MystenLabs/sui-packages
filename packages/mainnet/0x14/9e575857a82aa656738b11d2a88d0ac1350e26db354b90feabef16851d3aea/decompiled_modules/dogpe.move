module 0x149e575857a82aa656738b11d2a88d0ac1350e26db354b90feabef16851d3aea::dogpe {
    struct DOGPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGPE>(arg0, 6, b"DOGPE", b"Dogtar Pepe", b"Dogtar pepe is coming is for you on sui, join the party", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012139_59f9b55468.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

