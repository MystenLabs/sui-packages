module 0xc4d622c169f427b3426ab03d36506b8fd0b6ce74fca5df8ba3c78d94176bdaaf::emf {
    struct EMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMF>(arg0, 6, b"Emf", b"Emoji fan", b"Token meme fan emoji ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732542507882.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

