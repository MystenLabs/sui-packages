module 0xa7b55d64c5f60a03113fe6ccfdf6c5e6a9e295ebac74d76001983676425066aa::potato {
    struct POTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATO>(arg0, 6, b"Potato", b"Potato on SUI", b"A Million $ Potato - Not For Sale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/potatophoto_5e312be0d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

