module 0x340f06844906d53f93b1ee785a891523d76f0e2f2d33bfa9e8dffbea307cb024::tim {
    struct TIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIM>(arg0, 9, b"TIM", b"Time ", b"TIME is the most luxury, purchase time and don't forget that TIME IS MONEY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca1e503a-855c-4fd7-84a3-5ecd4b9631b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

