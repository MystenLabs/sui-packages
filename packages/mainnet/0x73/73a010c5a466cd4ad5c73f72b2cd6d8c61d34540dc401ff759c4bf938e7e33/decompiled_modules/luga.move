module 0x7373a010c5a466cd4ad5c73f72b2cd6d8c61d34540dc401ff759c4bf938e7e33::luga {
    struct LUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA>(arg0, 6, b"LUGA", b"Luga", b"it a beluga whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_16_23_21_68534edf4e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

