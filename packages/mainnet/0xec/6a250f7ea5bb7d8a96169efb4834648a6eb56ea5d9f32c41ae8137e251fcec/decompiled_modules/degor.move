module 0xec6a250f7ea5bb7d8a96169efb4834648a6eb56ea5d9f32c41ae8137e251fcec::degor {
    struct DEGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGOR>(arg0, 6, b"DEGOR", b"DEGENERATE GORILLA", b"GORILLAS IN A WORLD OF DEGENERACY & THE VAST SUI SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/degor_sui_828376e56f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

