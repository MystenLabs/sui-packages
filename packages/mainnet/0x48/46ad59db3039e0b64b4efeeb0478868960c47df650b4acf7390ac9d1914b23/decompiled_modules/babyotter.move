module 0x4846ad59db3039e0b64b4efeeb0478868960c47df650b4acf7390ac9d1914b23::babyotter {
    struct BABYOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYOTTER>(arg0, 6, b"BABYOTTER", b"Baby Otter", b"Don't miss Baby Otter with 0% taxes! Our project is designed specifically for the community. Join us and grow together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/78abe4b1d5ddc88ddcbbf77e9d2fef12_0bff216583.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYOTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

