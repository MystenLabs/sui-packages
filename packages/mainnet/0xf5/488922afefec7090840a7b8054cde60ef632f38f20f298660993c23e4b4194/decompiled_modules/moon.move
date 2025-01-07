module 0xf5488922afefec7090840a7b8054cde60ef632f38f20f298660993c23e4b4194::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"MOON AI", b"Moon is a reflaction of btc dominance in crypto market, it will make a fantastic move and will go to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000145007_eac5faa251.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

