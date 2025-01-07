module 0x3119257c5039b68ba7b6f72daee06ee6cc5674ad9fa8f17c914fcc85578b3f2e::pinkwhale {
    struct PINKWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKWHALE>(arg0, 6, b"PINKWHALE", b"PINK WHALE", b"When you see the pink Sousa chinensis, luck will come upon you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061586_b071e9088a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

