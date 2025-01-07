module 0xf5f8595b669c567bb96fc1f383a2fffe6c505a2085480f1e56989c2922db665e::spo {
    struct SPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPO>(arg0, 6, b"SPO", b"SUI PEPE OFFICIAL", b"Sui Pepe Official is the first ecosystem-oriented memecoin! TWITTER: https://twitter.com/SuiPepeOff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/J4OCVsC.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0xde81f835ac9aea3fb868f2b67826ac466056dd836dbc5bb05b43a0c8a3608cfa;
        0x2::coin::mint_and_transfer<SPO>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPO>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

