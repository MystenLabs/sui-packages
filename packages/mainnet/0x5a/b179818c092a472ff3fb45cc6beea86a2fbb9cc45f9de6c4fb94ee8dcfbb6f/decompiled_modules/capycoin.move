module 0x5ab179818c092a472ff3fb45cc6beea86a2fbb9cc45f9de6c4fb94ee8dcfbb6f::capycoin {
    struct CAPYCOIN has drop {
        dummy_field: bool,
    }

    struct CapyTreasuryCap has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<CAPYCOIN>,
        metadata: 0x2::coin::CoinMetadata<CAPYCOIN>,
    }

    fun init(arg0: CAPYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYCOIN>(arg0, 9, b"CAPY", b"CapyCoin", b"Capybara-themed coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-df824314ebcc4e2fbdb344bb2ce1a7ae.r2.dev/Capy%20Coin.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPYCOIN>>(0x2::coin::mint<CAPYCOIN>(&mut v2, 500000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = CapyTreasuryCap{
            id       : 0x2::object::new(arg1),
            cap      : v2,
            metadata : v1,
        };
        0x2::transfer::share_object<CapyTreasuryCap>(v3);
    }

    // decompiled from Move bytecode v6
}

