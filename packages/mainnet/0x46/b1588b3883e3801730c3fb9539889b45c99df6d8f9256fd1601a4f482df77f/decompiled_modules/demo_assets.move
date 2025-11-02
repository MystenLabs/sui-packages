module 0x46b1588b3883e3801730c3fb9539889b45c99df6d8f9256fd1601a4f482df77f::demo_assets {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
    }

    struct DEMO_ASSETS has drop {
        dummy_field: bool,
    }

    struct Faucet has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<DEMO_ASSETS>,
        per_tx_limit: u64,
    }

    public fun faucet_mint(arg0: &mut Faucet, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(arg2 <= arg0.per_tx_limit, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEMO_ASSETS>>(0x2::coin::mint<DEMO_ASSETS>(&mut arg0.cap, arg2, arg3), arg1);
    }

    public fun get_faucet_limit(arg0: &Faucet) : u64 {
        arg0.per_tx_limit
    }

    fun init(arg0: DEMO_ASSETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO_ASSETS>(arg0, 9, b"OTTR", b"OTTR Token", b"Demo faucet coin for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Faucet{
            id           : 0x2::object::new(arg1),
            cap          : v0,
            per_tx_limit : 1000000000000000000,
        };
        0x2::transfer::share_object<Faucet>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEMO_ASSETS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleNFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<SimpleNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

