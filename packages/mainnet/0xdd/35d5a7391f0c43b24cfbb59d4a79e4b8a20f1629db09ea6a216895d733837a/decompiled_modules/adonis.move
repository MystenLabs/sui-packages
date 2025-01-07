module 0xdd35d5a7391f0c43b24cfbb59d4a79e4b8a20f1629db09ea6a216895d733837a::adonis {
    struct ADONIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADONIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADONIS>(arg0, 6, b"ADONIS", b"AdonisCoin", x"4c697374656e2c206368616d702c2077696e6e65727320646f6ee28099742077616974e28094746865792074616b652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ultima_077_764e510f9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADONIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADONIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

