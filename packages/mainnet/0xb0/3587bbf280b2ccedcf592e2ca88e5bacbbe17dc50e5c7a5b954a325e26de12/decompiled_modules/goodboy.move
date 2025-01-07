module 0xb03587bbf280b2ccedcf592e2ca88e5bacbbe17dc50e5c7a5b954a325e26de12::goodboy {
    struct GOODBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODBOY>(arg0, 9, b"GOODBOY", b"GoodBoy", b"Hey I'm GoodBoy! Your best friend on chain, good vibes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4DNcAxMMhWffAy5WTiJyxoCnMMkeXzrcw2RXJrakr7ym.png?size=xl&key=f6a541")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOODBOY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOODBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODBOY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

