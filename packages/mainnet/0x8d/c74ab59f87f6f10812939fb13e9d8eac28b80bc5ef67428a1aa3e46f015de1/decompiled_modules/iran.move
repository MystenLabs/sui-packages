module 0x8dc74ab59f87f6f10812939fb13e9d8eac28b80bc5ef67428a1aa3e46f015de1::iran {
    struct IRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRAN>(arg0, 6, b"IRAN", b"iran", b"Iran, once the heart of the Persian Empire, now a blend of ancient mystique and modern complexity, where tradition and technology dance a delicate waltz.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_00_00_17_fa562cb88f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

