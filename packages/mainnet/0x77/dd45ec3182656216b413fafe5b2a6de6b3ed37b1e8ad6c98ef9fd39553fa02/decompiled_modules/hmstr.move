module 0x77dd45ec3182656216b413fafe5b2a6de6b3ed37b1e8ad6c98ef9fd39553fa02::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTR>(arg0, 6, b"Hmstr", b"Hamster Kombat", b"Bullish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000193666_7f3589aea6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

