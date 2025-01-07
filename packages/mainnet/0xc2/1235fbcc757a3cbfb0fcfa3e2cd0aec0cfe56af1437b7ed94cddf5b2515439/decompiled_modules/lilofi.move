module 0xc21235fbcc757a3cbfb0fcfa3e2cd0aec0cfe56af1437b7ed94cddf5b2515439::lilofi {
    struct LILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILOFI>(arg0, 6, b"LILOFI", b"Little Lofi", b"Little Loffi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7303_8eeab298fb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

