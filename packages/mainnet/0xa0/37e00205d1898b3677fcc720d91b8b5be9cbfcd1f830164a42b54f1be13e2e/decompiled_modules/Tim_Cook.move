module 0xa037e00205d1898b3677fcc720d91b8b5be9cbfcd1f830164a42b54f1be13e2e::Tim_Cook {
    struct TIM_COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIM_COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIM_COOK>(arg0, 9, b"COOK", b"Tim Cook", b"cooking since 1999. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1535420431766671360/Pwq-1eJc_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIM_COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIM_COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

