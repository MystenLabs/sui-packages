module 0x10c965fa0e8ecda1634348f5d3fcddb20e7e0b8ebce89f7e0d9cf7c9faab41b5::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 6, b"Ccc", b"f", b"c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_a7972a9af5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

