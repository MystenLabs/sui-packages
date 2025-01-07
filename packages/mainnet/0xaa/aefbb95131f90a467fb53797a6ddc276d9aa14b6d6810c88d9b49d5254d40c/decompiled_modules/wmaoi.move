module 0xaaaefbb95131f90a467fb53797a6ddc276d9aa14b6d6810c88d9b49d5254d40c::wmaoi {
    struct WMAOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMAOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMAOI>(arg0, 6, b"Wmaoi", b"walkingmaoi", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2bbe679346.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMAOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMAOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

