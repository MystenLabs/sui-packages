module 0x3581552c366a1bd8a391b98a464a295e6d050bb1c9130cf9a782d2f31092fb::beisheng7_coin {
    struct BEISHENG7_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEISHENG7_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEISHENG7_COIN>(arg0, 8, b"BEISHENG7_COIN", b"BEISHENG7_COIN", b"this is my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/191969175?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEISHENG7_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEISHENG7_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

