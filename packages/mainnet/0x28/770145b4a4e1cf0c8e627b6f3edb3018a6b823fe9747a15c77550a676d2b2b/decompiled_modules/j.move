module 0x28770145b4a4e1cf0c8e627b6f3edb3018a6b823fe9747a15c77550a676d2b2b::j {
    struct J has drop {
        dummy_field: bool,
    }

    fun init(arg0: J, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J>(arg0, 6, b"J", b"jsui", b"Justice from Sui Court ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0095_c40947fad4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<J>>(v1);
    }

    // decompiled from Move bytecode v6
}

