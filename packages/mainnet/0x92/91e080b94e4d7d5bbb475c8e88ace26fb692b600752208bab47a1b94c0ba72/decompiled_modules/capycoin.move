module 0x9291e080b94e4d7d5bbb475c8e88ace26fb692b600752208bab47a1b94c0ba72::capycoin {
    struct CAPYCOIN has drop {
        dummy_field: bool,
    }

    struct CapyTreasuryCap has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<CAPYCOIN>,
    }

    fun init(arg0: CAPYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAPYCOIN>(arg0, 9, b"CAPY", b"CapyCoin", b"Capybara-themed coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-df824314ebcc4e2fbdb344bb2ce1a7ae.r2.dev/CapyCoin.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPYCOIN>>(0x2::coin::mint<CAPYCOIN>(&mut v3, 500000000000000, arg1), v0);
        let v4 = CapyTreasuryCap{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::transfer<CapyTreasuryCap>(v4, v0);
    }

    // decompiled from Move bytecode v6
}

