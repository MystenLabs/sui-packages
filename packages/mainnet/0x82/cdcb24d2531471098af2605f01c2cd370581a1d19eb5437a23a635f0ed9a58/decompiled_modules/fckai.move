module 0x82cdcb24d2531471098af2605f01c2cd370581a1d19eb5437a23a635f0ed9a58::fckai {
    struct FCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FCKAI>(arg0, 6, b"FCKAI", b"FckAI by SuiAI", x"45766572796f6e65e2809973207469726564206f662074686973204149206d65746120637261702e20546865206d61726b6574e28099732062656767696e6720666f7220736f6d65207265616c20646567656e20656e65726779202446434b4149206973207768657265206974e2809973206174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2139_7952ee3228.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FCKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

