module 0xcab8ca71b1434a0e276702309ab07abd8abd9868161bcc86fe5539f82a222416::pip {
    struct PIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIP>(arg0, 9, b"PIP", b"Pipsqueak", x"f09fa690", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6763dd98ffdc3632146bb984ceff7ae5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

