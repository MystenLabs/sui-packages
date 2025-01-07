module 0x35ad49feff39db602c6d067f6b52913e551e23d4e0d187812ccece4fc498d070::wro {
    struct WRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRO>(arg0, 6, b"WRO", b"WEIRDO", b"only WEIRDO, Nothing else..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2777_b941bca2a6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

