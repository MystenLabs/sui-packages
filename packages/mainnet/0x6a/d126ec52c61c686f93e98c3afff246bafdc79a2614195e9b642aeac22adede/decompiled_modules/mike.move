module 0x6ad126ec52c61c686f93e98c3afff246bafdc79a2614195e9b642aeac22adede::mike {
    struct MIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKE>(arg0, 9, b"MIKE", b"MIKE TY SON", b"Blast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/4o249b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MIKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

