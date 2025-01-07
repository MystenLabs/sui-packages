module 0x805f0ac9fb3fbce97196313d0ddd5fbf376a32fdc5a55afcccf26bfeba18032c::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"Bird", b"bird", x"426972642e4d6f6e65792028426c52442920697320612063727970746f63757272656e637920616e640a0a6f70657261746573206f6e2074686520457468657265756d20706c6174666f726d2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983149638.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

