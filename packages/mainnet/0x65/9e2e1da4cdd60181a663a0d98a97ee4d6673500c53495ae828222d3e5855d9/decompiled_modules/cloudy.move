module 0x659e2e1da4cdd60181a663a0d98a97ee4d6673500c53495ae828222d3e5855d9::cloudy {
    struct CLOUDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDY>(arg0, 9, b"CLOUDY", b"Cloudy", b"Cloudy", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLOUDY>(&mut v2, 2141245000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOUDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

