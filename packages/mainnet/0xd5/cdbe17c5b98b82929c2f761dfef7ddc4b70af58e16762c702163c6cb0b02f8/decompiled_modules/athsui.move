module 0xd5cdbe17c5b98b82929c2f761dfef7ddc4b70af58e16762c702163c6cb0b02f8::athsui {
    struct ATHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATHSUI>(arg0, 6, b"ATHSUI", b"SUI ATH Breaker", b"A meme coin celebrating the historic moment when SUI broke its ATH! $ATHSUI is a coin for crypto enthusiasts who believe in the power and potential of SUI. Soaring arrows and a burst of energy symbolize its path to new heights. Join the community that believes ATH is just the beginning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66be4530_3fbd_43c8_b1a7_cfd79ca2f385_365aa7fb65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

