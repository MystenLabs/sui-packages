module 0x8ed2edd0147e308a14ef52569c8d6118033b4ebda86e55d3160481be58ababc6::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Happy Hoppy Rabbit", b"Happy Hoppy Rabbit on #Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731179642446.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

