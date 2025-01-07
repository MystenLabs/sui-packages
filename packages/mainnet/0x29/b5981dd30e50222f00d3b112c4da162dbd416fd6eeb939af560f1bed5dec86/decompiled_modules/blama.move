module 0x29b5981dd30e50222f00d3b112c4da162dbd416fd6eeb939af560f1bed5dec86::blama {
    struct BLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAMA>(arg0, 6, b"BLAMA", b"BabySuilama", b"https://t.me/babysuilama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_00_27_50_3e4e73fd55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

