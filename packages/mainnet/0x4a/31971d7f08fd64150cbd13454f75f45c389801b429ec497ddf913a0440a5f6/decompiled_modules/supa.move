module 0x4a31971d7f08fd64150cbd13454f75f45c389801b429ec497ddf913a0440a5f6::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"United Pnut of Ameri", b"Squirrels got banks, citizens got $UPA! Join the United Pnut of America and watch your wallet grow! only on @turbos_finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979818481.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

