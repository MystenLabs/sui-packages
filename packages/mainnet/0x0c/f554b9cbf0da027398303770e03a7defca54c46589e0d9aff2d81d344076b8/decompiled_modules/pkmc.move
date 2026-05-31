module 0xcf554b9cbf0da027398303770e03a7defca54c46589e0d9aff2d81d344076b8::pkmc {
    struct PKMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKMC>(arg0, 9, b"PKMC", b"Pkemon Club", b"Pkemon Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://treehousetoys.ca/cdn/shop/files/imgi_515_91d8b9de9da7455a85b23cfd3ff43d81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKMC>>(v1);
    }

    // decompiled from Move bytecode v7
}

