module 0x894e7ad9f31deaae294d1d8d88b9a124c3bec374294ecfe7c4330a4dfcc65097::suixa {
    struct SUIXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIXA>(arg0, 6, b"SUIXA", b"Sui Agent", b"The real Sui Agent. Follow your dreams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5450_9f4037ff21.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIXA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

