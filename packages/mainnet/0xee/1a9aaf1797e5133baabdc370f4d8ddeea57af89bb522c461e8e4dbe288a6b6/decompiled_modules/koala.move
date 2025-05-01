module 0xee1a9aaf1797e5133baabdc370f4d8ddeea57af89bb522c461e8e4dbe288a6b6::koala {
    struct KOALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOALA>(arg0, 6, b"KOALA", b"KOALA Sui", b"Koala Technology is a software development company based in Christchurch, providing high-quality and cost-effective software development services and solutions to businesses in various sectors. We embrace the Internet, advocate technology-driven, and create better products and services!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4635_4d19487373.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

