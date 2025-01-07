module 0xb51d1a1a4a35633dbefa706d2c3f4e9317a6d558f3cfce115e09ef5eb404e74::superfruits {
    struct SUPERFRUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERFRUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERFRUITS>(arg0, 6, b"SUPERFRUITS", b"SuperFruits AI", x"5265766f6c7574696f6e697a696e672057656233207769746820736d617274204149206167656e74732e0a0a5468697320697320746865206f6e6c79206f6666696369616c20737570657266727569747320414920746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul36_20241222164044_3578259749.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERFRUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERFRUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

