module 0xbbf186a9c89f9e68fd7722abde12defb9862cea97b188f6e4f27d3c8dd88c95b::cuca {
    struct CUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCA>(arg0, 6, b"Cuca", b"Cuca Cat", b"the most important value is meow?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1868_b2b4611aa0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

