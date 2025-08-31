module 0x390d86afc8e8e50764aa3e76f9d592f4f8fbf432369d0cd60a7cdc52025abed9::look {
    struct LOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOK>(arg0, 6, b"LOOK", b"look", b"Sui Millionaire Look", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008803_ead69067d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

