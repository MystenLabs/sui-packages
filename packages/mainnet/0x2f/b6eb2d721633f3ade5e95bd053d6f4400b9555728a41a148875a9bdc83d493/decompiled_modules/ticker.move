module 0x2fb6eb2d721633f3ade5e95bd053d6f4400b9555728a41a148875a9bdc83d493::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 9, b"TICKER", b"DHRAM", b"DUBAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/528398c2-b642-43fb-bda6-20c6f31837e4-1000099971.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

