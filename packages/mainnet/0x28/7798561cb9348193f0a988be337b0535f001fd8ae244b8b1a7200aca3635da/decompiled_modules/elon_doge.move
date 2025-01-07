module 0x287798561cb9348193f0a988be337b0535f001fd8ae244b8b1a7200aca3635da::elon_doge {
    struct ELON_DOGE has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 8, b"ELON DOGE", b"EDOGE", b"ELON DOGE is a token inspired by the meme culture and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/7fc3a42a722c4f6b99eed0f2bded7f09.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: ELON_DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<ELON_DOGE>(arg0, arg1);
        0x2::coin::mint_and_transfer<ELON_DOGE>(&mut v0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELON_DOGE>>(v0);
    }

    // decompiled from Move bytecode v6
}

