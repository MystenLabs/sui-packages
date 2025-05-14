module 0xc3e2cc0737a160e0e119d0b573b258ae766c077eb0e5359a9ea1a13e67dc83d4::launchpad {
    struct TUSK_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenPool has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        total_supply: u64,
        minted: u64,
        treasury: 0x2::coin::TreasuryCap<TUSK_TOKEN>,
        reserve: 0x2::balance::Balance<0x2::coin::Coin<0x2::sui::SUI>>,
        base_price: u64,
        slope: u64,
        active: bool,
    }

    struct TokenLaunched has copy, drop {
        pool_id: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        total_supply: u64,
        base_price: u64,
        slope: u64,
    }

    struct TokensMinted has copy, drop {
        pool_id: address,
        amount: u64,
        sui_bonded: u64,
        buyer: address,
    }

    public entry fun create_token(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(arg3 > 0, 7);
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) >= 3 && 0x1::string::length(&v0) <= 32, 1);
        assert!(0x1::string::length(&v1) >= 2 && 0x1::string::length(&v1) <= 8, 2);
        let v2 = TUSK_TOKEN{dummy_field: false};
        let (v3, v4) = 0x2::coin::create_currency<TUSK_TOKEN>(v2, 9, arg1, arg0, b"Token launched via TUSK Launchpad", 0x1::option::none<0x2::url::Url>(), arg4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSK_TOKEN>>(v4);
        let v5 = TokenPool{
            id           : 0x2::object::new(arg4),
            name         : v0,
            symbol       : v1,
            total_supply : 1000000000,
            minted       : 0,
            treasury     : v3,
            reserve      : 0x2::balance::zero<0x2::coin::Coin<0x2::sui::SUI>>(),
            base_price   : arg2,
            slope        : arg3,
            active       : true,
        };
        let v6 = TokenLaunched{
            pool_id      : 0x2::object::uid_to_address(&v5.id),
            name         : v0,
            symbol       : v1,
            total_supply : 1000000000,
            base_price   : arg2,
            slope        : arg3,
        };
        0x2::event::emit<TokenLaunched>(v6);
        0x2::transfer::public_share_object<TokenPool>(v5);
    }

    public fun get_price(arg0: &TokenPool, arg1: u64) : u64 {
        assert!(arg0.active, 4);
        assert!(arg0.minted + arg1 <= arg0.total_supply, 5);
        (arg0.base_price + arg0.slope * arg0.minted + arg0.base_price + arg0.slope * (arg0.minted + arg1)) / 2 * arg1
    }

    public entry fun mint_tokens(arg0: &mut TokenPool, arg1: u64, arg2: 0x2::coin::Coin<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        assert!(arg0.minted + arg1 <= arg0.total_supply, 5);
        let v0 = get_price(arg0, arg1);
        assert!(0x2::coin::value<0x2::coin::Coin<0x2::sui::SUI>>(&arg2) >= v0, 3);
        let v1 = 0x2::coin::into_balance<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        0x2::balance::join<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.reserve, 0x2::balance::split<0x2::coin::Coin<0x2::sui::SUI>>(&mut v1, v0));
        arg0.minted = arg0.minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TUSK_TOKEN>>(0x2::coin::mint<TUSK_TOKEN>(&mut arg0.treasury, arg1, arg3), 0x2::tx_context::sender(arg3));
        if (0x2::balance::value<0x2::coin::Coin<0x2::sui::SUI>>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::coin::Coin<0x2::sui::SUI>>>(0x2::coin::from_balance<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x2::coin::Coin<0x2::sui::SUI>>(v1);
        };
        let v2 = TokensMinted{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            amount     : arg1,
            sui_bonded : v0,
            buyer      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokensMinted>(v2);
    }

    // decompiled from Move bytecode v6
}

