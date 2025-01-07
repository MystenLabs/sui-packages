module 0x7e4960936ea6e5cd6f17f822e7747afd01ccf352c88819869f984919b029ebc::suicorgi {
    struct SUICORGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICORGI>(arg0, 6, b"Suicorgi", b"Suidogcorgi", b"SUI CORGI is very fun and much love SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016479_1cd17d30df_2c01728775.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICORGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICORGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

