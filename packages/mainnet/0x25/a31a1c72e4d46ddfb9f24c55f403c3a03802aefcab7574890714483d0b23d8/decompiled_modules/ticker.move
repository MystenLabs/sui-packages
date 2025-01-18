module 0x25a31a1c72e4d46ddfb9f24c55f403c3a03802aefcab7574890714483d0b23d8::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 1, b"Ticker", b"Ticker for test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKER>>(v1);
        0x2::coin::mint_and_transfer<TICKER>(&mut v2, 100000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

