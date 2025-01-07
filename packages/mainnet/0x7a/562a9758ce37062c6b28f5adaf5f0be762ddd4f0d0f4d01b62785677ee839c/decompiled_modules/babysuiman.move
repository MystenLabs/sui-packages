module 0x7a562a9758ce37062c6b28f5adaf5f0be762ddd4f0d0f4d01b62785677ee839c::babysuiman {
    struct BABYSUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUIMAN>(arg0, 6, b"BabySuiman", b"Baby Suiman", b"Baby Suiman First Baby on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9204_a5c3d9e74a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

