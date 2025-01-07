module 0x30833d2b7d85b3b2620b1387aade3bd46e6ded0dfb5d504fca189ea253c520ab::spongebob {
    struct SPONGEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBOB>(arg0, 6, b"Spongebob", b"Spongebob Suipants", b"Spongebob Suipants community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_09_48_28_46b93559e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

