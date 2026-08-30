module 0x75e90d3da90146ce4ef776949a57fca68530797b9d3aa511e0998571252193ee::ufvolcg {
    struct UFVOLCG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFVOLCG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFVOLCG>(arg0, 0, b"UFVOLCG", b"Sui Blue Gift User FVOLCG", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFVOLCG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UFVOLCG>>(0x2::coin::mint<UFVOLCG>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFVOLCG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

