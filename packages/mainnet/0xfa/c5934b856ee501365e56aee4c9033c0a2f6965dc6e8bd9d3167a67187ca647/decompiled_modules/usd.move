module 0xfac5934b856ee501365e56aee4c9033c0a2f6965dc6e8bd9d3167a67187ca647::usd {
    struct UsdV9 has drop, store {
        dummy_field: bool,
    }

    struct USDState has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<UsdV9>,
        metadata: 0x2::coin::CoinMetadata<UsdV9>,
        owner: address,
    }

    public entry fun burn_tokens(arg0: &mut USDState, arg1: 0x2::coin::Coin<UsdV9>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::coin::burn<UsdV9>(&mut arg0.cap, arg1);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UsdV9{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<UsdV9>(v0, 8, b"FHF USD", b"FHF USD", b"Family Heritage Foundation USD", 0x1::option::none<0x2::url::Url>(), arg0);
        let v3 = USDState{
            id       : 0x2::object::new(arg0),
            cap      : v1,
            metadata : v2,
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<USDState>(v3);
    }

    public entry fun mint_tokens(arg0: &mut USDState, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<UsdV9>>(0x2::coin::mint<UsdV9>(&mut arg0.cap, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

