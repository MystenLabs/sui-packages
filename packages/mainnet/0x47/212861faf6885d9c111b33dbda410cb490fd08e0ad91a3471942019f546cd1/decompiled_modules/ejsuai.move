module 0x47212861faf6885d9c111b33dbda410cb490fd08e0ad91a3471942019f546cd1::ejsuai {
    struct EJSUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EJSUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EJSUAI>(arg0, 6, b"EJSUAI", b"Eren Jaeger AI", x"5175616e646f2076692073656e74697465206465626f6c692c7269636f7264617465206327c3a820717569207175616c63756e6f2070726f6e746f206164206173636f6c7461727669", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000045077_1a8a35fea3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EJSUAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EJSUAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

