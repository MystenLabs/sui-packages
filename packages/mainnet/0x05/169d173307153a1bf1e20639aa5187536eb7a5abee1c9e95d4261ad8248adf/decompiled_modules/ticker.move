module 0x5169d173307153a1bf1e20639aa5187536eb7a5abee1c9e95d4261ad8248adf::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 9, b"TICKER", b"Best ticke", b"Best ticker on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/623139ea-f438-428c-8490-581f057985e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

