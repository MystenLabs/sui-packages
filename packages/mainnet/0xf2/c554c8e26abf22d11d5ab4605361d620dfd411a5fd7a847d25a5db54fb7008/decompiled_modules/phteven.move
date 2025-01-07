module 0xf2c554c8e26abf22d11d5ab4605361d620dfd411a5fd7a847d25a5db54fb7008::phteven {
    struct PHTEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHTEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHTEVEN>(arg0, 6, b"Phteven", b"Boss Phteven", b"Who cares about Phteven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/phteven_d2c09a05b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHTEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHTEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

