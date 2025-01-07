module 0x9aa3045af72078aa57f2a962e0d0321f6358de1bdaa0660fd8ac6d1ec6d26b9f::bluegold {
    struct BLUEGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEGOLD>(arg0, 6, b"BlueGold", b"What color is the dress", b"The most controversial dress. Is it blue and black or is it white and gold?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7868_1d94d4070d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

