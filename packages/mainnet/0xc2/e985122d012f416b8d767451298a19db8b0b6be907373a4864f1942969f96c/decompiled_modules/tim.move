module 0xc2e985122d012f416b8d767451298a19db8b0b6be907373a4864f1942969f96c::tim {
    struct TIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIM>(arg0, 6, b"TIM", b"Tim On Sui", b"smartest ai living", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tim_fe2e79fac6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

