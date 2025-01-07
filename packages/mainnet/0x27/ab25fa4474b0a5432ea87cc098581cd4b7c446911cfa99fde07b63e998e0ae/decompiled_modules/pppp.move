module 0x27ab25fa4474b0a5432ea87cc098581cd4b7c446911cfa99fde07b63e998e0ae::pppp {
    struct PPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPP>(arg0, 6, b"PPPP", b"PeePeePooPoo", b"Peepee, and Poopoo. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9433_d5e7bbe9e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

