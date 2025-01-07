module 0x76c44d6c0063a0d433c56f91db288ecc5e82520f02a8e3de7c06c6cba70b9aa2::idiot {
    struct IDIOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDIOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDIOT>(arg0, 6, b"IDIOT", b"Idiocracy", b"People are idiots. Period.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732538523108.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDIOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDIOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

