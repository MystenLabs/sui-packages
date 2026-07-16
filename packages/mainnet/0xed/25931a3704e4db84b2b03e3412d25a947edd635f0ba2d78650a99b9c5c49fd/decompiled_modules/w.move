module 0xed25931a3704e4db84b2b03e3412d25a947edd635f0ba2d78650a99b9c5c49fd::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"W", b"Walrus", b"Walrus GOOH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784186686902.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

