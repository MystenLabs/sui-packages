module 0x753eebbe70eb802a534930c57cdf18d40905b288e6c2fe8ec84ac591cb55b8dc::pipsea {
    struct PIPSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPSEA>(arg0, 6, b"Pipsea", b"Pipsea on sui", b"Just a bottle floating in the ocean, carried away by the current, destination unknown. Inside, a message tucked away, with no clue as to who wrote it or when. The vast and deep ocean seems to be a silent witness to the bottles journey, crossing high waves, storms, and scorching sunlight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pipsea_766c9b558a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPSEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

