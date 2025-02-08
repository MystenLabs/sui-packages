module 0x99615e2001abeb72f52a5497340bfcb0478d52371fe0882df9731cd7fe220942::ndng {
    struct NDNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDNG>(arg0, 6, b"NDng", b"New DENGUE", b"Came to suck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038597_07d9dd107e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

