module 0x99edb96ebce7ecd896e6200fbb7fe221ed3e01e6ee3e620b1072cc6ceebd5327::bullcoin {
    struct BULLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLCOIN>(arg0, 9, b"BULLCOIN", b"Bullcoin", b"The coin for the bulls. We will win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5wNst4RK6UKQwYG9SB2zAHKTgD2rND33DpsHLDD6pump.png?size=xl&key=5d4338")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLCOIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLCOIN>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

