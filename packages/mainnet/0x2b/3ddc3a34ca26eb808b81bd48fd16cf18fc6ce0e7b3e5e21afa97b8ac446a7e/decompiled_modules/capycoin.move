module 0x2b3ddc3a34ca26eb808b81bd48fd16cf18fc6ce0e7b3e5e21afa97b8ac446a7e::capycoin {
    struct Capy has copy, drop, store {
        dummy_field: bool,
    }

    struct CapyTreasuryCap has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<Capy>,
        metadata: 0x2::coin::CoinMetadata<Capy>,
    }

    fun temp_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Capy{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<Capy>(v0, 9, b"CAPY", b"CapyCoin", b"Capybara-themed coin", 0x1::option::none<0x2::url::Url>(), arg0);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<Capy>>(0x2::coin::mint<Capy>(&mut v3, 500000000000000, arg0), 0x2::tx_context::sender(arg0));
        let v4 = CapyTreasuryCap{
            id       : 0x2::object::new(arg0),
            cap      : v3,
            metadata : v2,
        };
        0x2::transfer::share_object<CapyTreasuryCap>(v4);
    }

    // decompiled from Move bytecode v6
}

