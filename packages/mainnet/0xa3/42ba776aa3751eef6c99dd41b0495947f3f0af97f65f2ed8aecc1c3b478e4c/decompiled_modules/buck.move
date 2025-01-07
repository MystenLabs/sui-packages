module 0xa342ba776aa3751eef6c99dd41b0495947f3f0af97f65f2ed8aecc1c3b478e4c::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 9, b"NEPTUNUS", b"Neptunus", b"NEPTUNUS is an AI-powered trading bot offering advanced features for crypto enthusiasts. It includes instant contract audits, real-time price charts, swap functionality, and trend analysis across multiple chains (SUI, Ethereum, BSC, with Solana in testing). The bot automates buy/sell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F1000175349_af541f19f3.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUCK>>(0x2::coin::mint<BUCK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUCK>>(v2);
    }

    // decompiled from Move bytecode v6
}

