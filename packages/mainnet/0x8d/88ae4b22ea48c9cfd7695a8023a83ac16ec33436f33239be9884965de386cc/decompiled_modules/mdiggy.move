module 0x8d88ae4b22ea48c9cfd7695a8023a83ac16ec33436f33239be9884965de386cc::mdiggy {
    struct MDIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDIGGY>(arg0, 6, b"MDIGGY", b"MAGA DIGGY", b"MAGA DIGGY. WIN! WINW WIN! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959575923.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDIGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDIGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

