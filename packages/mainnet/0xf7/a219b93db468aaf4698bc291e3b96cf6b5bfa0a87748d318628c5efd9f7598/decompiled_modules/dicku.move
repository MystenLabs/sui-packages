module 0xf7a219b93db468aaf4698bc291e3b96cf6b5bfa0a87748d318628c5efd9f7598::dicku {
    struct DICKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKU>(arg0, 6, b"DICKU", b"DICKU CAT", b"DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU DICKU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000169464_4a5d5fa886.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

