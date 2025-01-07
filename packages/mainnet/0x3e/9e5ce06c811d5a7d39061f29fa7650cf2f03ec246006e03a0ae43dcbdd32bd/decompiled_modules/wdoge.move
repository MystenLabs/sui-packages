module 0x3e9e5ce06c811d5a7d39061f29fa7650cf2f03ec246006e03a0ae43dcbdd32bd::wdoge {
    struct WDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGE>(arg0, 9, b"WDOGE", b"wave doge", b"Wave doge wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2bc2989e-3e50-4247-9b12-c7ae94d87c03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

