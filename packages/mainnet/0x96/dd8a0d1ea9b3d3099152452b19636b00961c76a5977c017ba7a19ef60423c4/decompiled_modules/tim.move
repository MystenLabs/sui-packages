module 0x96dd8a0d1ea9b3d3099152452b19636b00961c76a5977c017ba7a19ef60423c4::tim {
    struct TIM has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TIM>, arg1: 0x2::coin::Coin<TIM>) {
        0x2::coin::burn<TIM>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TIM>>(0x2::coin::mint<TIM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIM>(arg0, 18, b"tim", b"TIM", b"TIM token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

