module 0xfc3c8346346f4ff2b3bc2bcd706fe5415cdda00bbeb6bbfa75424450760e21d1::gope {
    struct GOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOPE>(arg0, 6, b"GOPE", b"GOPE SUI", b"We Introduce to you $GOPE, the blue #pepe frog by Matt Furie based on Mindviscosity books ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x420110d74c4c3ea14043a09e81fad53e1932f54c_65584b5437.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

