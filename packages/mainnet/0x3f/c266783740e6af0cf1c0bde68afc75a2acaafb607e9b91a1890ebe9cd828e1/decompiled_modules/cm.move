module 0x3fc266783740e6af0cf1c0bde68afc75a2acaafb607e9b91a1890ebe9cd828e1::cm {
    struct CM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CM>(arg0, 6, b"CM", b"Cheems Museum", b"Some high quality Balltze art!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0625_60b1b8e4b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CM>>(v1);
    }

    // decompiled from Move bytecode v6
}

