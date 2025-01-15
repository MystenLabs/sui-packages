module 0xda5d8c3426d29eae6f7cb9a4aa5a94da7542e8ddc645d7b09df8f465ed7454a::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JACK>(arg0, 6, b"JACK", b"Jack Sui by SuiAI", b"Jack Sui, the smartest fish in the Sui blockchain! Powered by AI, Jack explores the deepest waters of $SuiAI in search of the legendary lost treasure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/El_texto_del_parrafo_9_ff74da8b20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JACK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

