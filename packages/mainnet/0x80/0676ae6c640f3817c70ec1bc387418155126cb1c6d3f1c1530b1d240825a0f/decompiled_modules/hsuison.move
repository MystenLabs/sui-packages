module 0x800676ae6c640f3817c70ec1bc387418155126cb1c6d3f1c1530b1d240825a0f::hsuison {
    struct HSUISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUISON>(arg0, 6, b"HSUISON", b"Homer Suison", b"Oh no!!! Homer drunk Sui water and it turned him blue.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5883_e017f72d1b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSUISON>>(v1);
    }

    // decompiled from Move bytecode v6
}

