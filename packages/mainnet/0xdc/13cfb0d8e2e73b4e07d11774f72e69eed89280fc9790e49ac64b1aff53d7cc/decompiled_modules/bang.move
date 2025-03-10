module 0xdc13cfb0d8e2e73b4e07d11774f72e69eed89280fc9790e49ac64b1aff53d7cc::bang {
    struct BANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANG>(arg0, 6, b"BANG", b"COTTON CANDY BANG", b"THE BEST BANG ON EARTH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/002096726_jpg_0b78a06e49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

