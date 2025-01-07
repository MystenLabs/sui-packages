module 0xf542a7aeb9fe76da6bfbb67e969f8756999a1d2efdd63235c8e1b5f6e9784ed2::likedog {
    struct LIKEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIKEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIKEDOG>(arg0, 6, b"LikeDog", b"Like Dog", b"The First Pas Meme coin to reach 1M likes on a post!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/99462y_67a16f6b33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIKEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIKEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

