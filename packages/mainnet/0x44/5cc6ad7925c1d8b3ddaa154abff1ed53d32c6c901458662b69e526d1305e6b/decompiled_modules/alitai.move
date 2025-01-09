module 0x445cc6ad7925c1d8b3ddaa154abff1ed53d32c6c901458662b69e526d1305e6b::alitai {
    struct ALITAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALITAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALITAI>(arg0, 6, b"ALITAI", b"Battle Angel Alita AI by SuiAI", b"Alita is an agent, a pretty young girl with depicted eyes and at the same time a perfect agent who, despite her inhuman strength, is able to empathize and, of course, fall in love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/orig_05e496ee28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALITAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALITAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

