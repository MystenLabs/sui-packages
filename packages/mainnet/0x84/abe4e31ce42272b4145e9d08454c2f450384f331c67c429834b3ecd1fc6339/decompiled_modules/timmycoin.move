module 0x84abe4e31ce42272b4145e9d08454c2f450384f331c67c429834b3ecd1fc6339::timmycoin {
    struct TIMMYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMMYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMMYCOIN>(arg0, 6, b"TIMMYCOIN", b"TIMMY TURNER COIN", b"Timmy Turner Helps you make wishes.......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_7f619ba833.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMMYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMMYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

