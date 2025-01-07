module 0xf6d226667023ae87ff55d9f135486fc0c1ec761a47143ac1284cd5db661cde47::mola {
    struct MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLA>(arg0, 6, b"MOLA", b"SUI MOLA", b"Kookiest Goofballs of the Sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mola3_3cdf0380c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

