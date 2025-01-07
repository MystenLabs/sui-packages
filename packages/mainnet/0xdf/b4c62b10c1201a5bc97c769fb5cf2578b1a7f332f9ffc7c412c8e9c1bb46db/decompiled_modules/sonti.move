module 0xdfb4c62b10c1201a5bc97c769fb5cf2578b1a7f332f9ffc7c412c8e9c1bb46db::sonti {
    struct SONTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONTI>(arg0, 6, b"SONTI", b"Sonti", x"48692c2049e280996d20616e206174686c6574696320616e642066756e6e7920636f636b2c207768617420656c736520646f20796f752077616e742066726f6d206d653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998314351.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

