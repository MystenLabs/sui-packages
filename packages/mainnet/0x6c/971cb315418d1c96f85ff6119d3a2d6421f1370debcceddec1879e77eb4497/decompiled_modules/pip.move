module 0x6c971cb315418d1c96f85ff6119d3a2d6421f1370debcceddec1879e77eb4497::pip {
    struct PIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIP>(arg0, 6, b"PIP", b"Pipsui", b"Just a bottle floating in the ocean, carried away by the current, destination unknown. Inside, a message tucked away, with no clue as to who wrote it or when. The vast and deep ocean seems to be a silent witness to the bottles journey, crossing high waves, storms, and scorching sunlight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000066392_56e491f176.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

