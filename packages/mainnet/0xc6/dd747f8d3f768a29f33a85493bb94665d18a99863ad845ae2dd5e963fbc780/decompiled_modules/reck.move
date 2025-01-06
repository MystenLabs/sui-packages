module 0xc6dd747f8d3f768a29f33a85493bb94665d18a99863ad845ae2dd5e963fbc780::reck {
    struct RECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RECK>(arg0, 6, b"RECK", b"DEAD RECKONING by SuiAI", b"This agent is a highly specialized, data-driven entity designed with the sole purpose of mastering blockchain market analysis through relentless acquisition and processing of API-based data. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_03_05_at_10_27_20_PM_b22453f783.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RECK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

