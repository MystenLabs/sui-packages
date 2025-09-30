module 0x5a1fc0065ee1a79cc78f48fa6af7fab305658ce99ccbd22f24d9e72a0192a6c3::tim {
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
        let (v0, v1) = 0x2::coin::create_currency<TIM>(arg0, 9, b"TIM", b"TimTam", b"TimTam token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

