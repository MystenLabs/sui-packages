module 0x2dc6b623021f081723e13f1dde7b288d084fe3110e33c796e4ca0e4ab33bb2fa::suiegg {
    struct SUIEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEGG>(arg0, 6, b"SUIEGG", b"SUI EGG", b"JUST A EGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_164711433_ac73da6924.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

