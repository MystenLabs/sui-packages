module 0x2ddeda6b8b51ebbab6b2505d099b7db171a33c1476847eba8f6fd13216e7bbd2::motivation {
    struct MOTIVATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTIVATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTIVATION>(arg0, 6, b"MOTIVATION", b"MOTIVATION AI", b"A bot designed to inspire and motivate you with phrases full of positive energy, ideal for any time of the day. Perfect for recharging your batteries and achieving your goals with enthusiasm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736087929339.27")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTIVATION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTIVATION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

