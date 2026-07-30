module 0xd13f9efd146f89beae7ee14f01d517fef37efd09c7e94215a0cec55a60c839c0::tfe00dd70 {
    struct TFE00DD70 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TFE00DD70>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TFE00DD70>>(0x2::coin::mint<TFE00DD70>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TFE00DD70, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFE00DD70>(arg0, 9, b"USAA", b"USAA", b"USAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/52kjYb4y/Screen-Shot-2026-07-27-231117-321.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFE00DD70>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFE00DD70>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

