module 0x89e9c15d719340278521401e9fad967cc1f724bdf4cfe787fd41457472e02e1f::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 9, b"CASH", b"Moneys Calling", b"Moneys calling, ring ring.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6rVy5oRuLzwgJP82KYHKaVNvdwCeWAa74WZrtKUSpump.png?size=xl&key=8bcd88")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CASH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

