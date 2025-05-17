module 0x634858261f930c581081256ce2b7e09deae3d8673ca5a2fce2b8af93e4fc8c7::showdown {
    struct SHOWDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOWDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOWDOWN>(arg0, 6, b"Showdown", b"Slipstream showdown", b"a game coming to roblox  in development were player get paid to play the idear is for the coin to go up and u earn money but in return u play", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747466465020.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOWDOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOWDOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

