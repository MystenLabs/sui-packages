module 0x8c2150ab570516a72640d6c89686f4c600a535fd01c20e9dbab62628ef0d5d74::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"Poop Nuggets", x"24504f4f50204e55474745545320e280942054686520546f6b656e205468617420536d656c6c73204c696b652050726f66697420286c69746572616c6c79292120f09f92a9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738522977988.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

