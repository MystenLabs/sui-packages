module 0x272b1875c46085c5f4939abfa4eb02a8ba7dda2fa03d47996f6b2d4054e5dfe5::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"$EYE", x"24457965206669727374207265616c20686f6e65737420746f6b656e0a70726f6a656374203230393921204c4c43204579652065636f6e6f6d7920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5085_2841e53abb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

