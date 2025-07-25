module 0x4d80296d0f0e773d9e1f292811771873fc8abee3a1df4743efb9188f1cbcd252::usd {
    struct Usd has drop, store {
        dummy_field: bool,
    }

    struct USDState has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<Usd>,
        metadata: 0x2::coin::CoinMetadata<Usd>,
        owner: address,
    }

    public entry fun burn_tokens(arg0: &mut USDState, arg1: 0x2::coin::Coin<Usd>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::coin::burn<Usd>(&mut arg0.cap, arg1);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Usd{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<Usd>(v0, 8, b"FHF USD", b"FHF USD", b"Family Heritage Foundation USD", 0x1::option::none<0x2::url::Url>(), arg0);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<Usd>>(0x2::coin::mint<Usd>(&mut arg0.cap, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

