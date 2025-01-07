module 0xae0c583da7de74742b46218edfea2b11acb076a7ed9d79a21c7a743d59bccf1a::dinogwl {
    struct DINOGWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOGWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOGWL>(arg0, 6, b"DINOGWL", b"dinosaur growling", b"the dinosaur growling to say he is hungry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/63456_227d3008a4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOGWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINOGWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

