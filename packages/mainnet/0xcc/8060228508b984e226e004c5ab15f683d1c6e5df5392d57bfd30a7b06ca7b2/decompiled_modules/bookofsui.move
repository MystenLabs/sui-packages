module 0xcc8060228508b984e226e004c5ab15f683d1c6e5df5392d57bfd30a7b06ca7b2::bookofsui {
    struct BOOKOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKOFSUI>(arg0, 6, b"BOOKOFSUI", b"Book Of Sui", b"The Only Book Of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O34bsxdt_400x400_1a5b70f333_2d44d97e54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKOFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKOFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

