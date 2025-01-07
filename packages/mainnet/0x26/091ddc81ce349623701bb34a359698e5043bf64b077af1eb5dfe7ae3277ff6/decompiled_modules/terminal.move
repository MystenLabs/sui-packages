module 0x26091ddc81ce349623701bb34a359698e5043bf64b077af1eb5dfe7ae3277ff6::terminal {
    struct TERMINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINAL>(arg0, 6, b"terminal", b"Terminal of Token", b"the memetic virus is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/A8rnTyqWyM6bPYqFTxA37YcwwXdQARP9AeL1XznQpump.png?size=lg&key=31bbeb"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERMINAL>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TERMINAL>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINAL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

