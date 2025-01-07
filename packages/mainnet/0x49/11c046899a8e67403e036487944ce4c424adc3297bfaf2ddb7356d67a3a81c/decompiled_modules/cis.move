module 0x4911c046899a8e67403e036487944ce4c424adc3297bfaf2ddb7356d67a3a81c::cis {
    struct CIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CIS>(arg0, 6, b"CIS", b"Community in Service by SuiAI", b"CiS is a token for the community. Tired of the days of greedy capitalism, CiS seeks to turn the traditional business models upside down by putting capitalism with socialistic traits steroids. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BURND_Logo_fb6d86e261.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

