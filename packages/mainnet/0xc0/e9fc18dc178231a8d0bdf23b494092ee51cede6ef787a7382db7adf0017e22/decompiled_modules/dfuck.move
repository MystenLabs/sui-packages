module 0xc0e9fc18dc178231a8d0bdf23b494092ee51cede6ef787a7382db7adf0017e22::dfuck {
    struct DFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFUCK>(arg0, 6, b"DFUCK", b"$DFUCK", b"duckfucksui on turbo launched officially", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994752951.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

