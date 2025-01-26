module 0xda13f3caf97743d6cb449c1b01c54e5e043b0adee3ec7ef446a9b61a947af0fb::pandabiao {
    struct PANDABIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDABIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PANDABIAO>(arg0, 6, b"PANDABIAO", b"Pandabiaocalls by SuiAI", b"Send this to millions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000043572_31fb11f5c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDABIAO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDABIAO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

