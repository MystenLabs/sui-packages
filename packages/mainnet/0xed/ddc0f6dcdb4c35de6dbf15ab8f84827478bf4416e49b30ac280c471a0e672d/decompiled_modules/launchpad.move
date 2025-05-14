module 0xedddc0f6dcdb4c35de6dbf15ab8f84827478bf4416e49b30ac280c471a0e672d::launchpad {
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

    public entry fun create_token(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) >= 3 && 0x1::string::length(&v0) <= 32, 1);
        assert!(0x1::string::length(&v1) >= 2 && 0x1::string::length(&v1) <= 8, 2);
        let v2 = 1000000;
        let v3 = 1000000000;
        let v4 = 2 * (2000000000000 - v2 * v3) / v3 * v3;
        let v5 = TUSK_TOKEN{dummy_field: false};
        let (v6, v7) = 0x2::coin::create_currency<TUSK_TOKEN>(v5, 9, arg1, arg0, b"Token launched via TUSK Launchpad", 0x1::option::none<0x2::url::Url>(), arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSK_TOKEN>>(v7);
        let v8 = TokenPool{
            id           : 0x2::object::new(arg2),
            name         : v0,
            symbol       : v1,
            total_supply : 1000000000,
            minted       : 0,
            treasury     : v6,
            reserve      : 0x2::balance::zero<0x2::coin::Coin<0x2::sui::SUI>>(),
            base_price   : v2,
            slope        : v4,
            active       : true,
        };
        let v9 = TokenLaunched{
            pool_id      : 0x2::object::uid_to_address(&v8.id),
            name         : v0,
            symbol       : v1,
            total_supply : 1000000000,
            base_price   : v2,
            slope        : v4,
        };
        0x2::event::emit<TokenLaunched>(v9);
        0x2::transfer::public_share_object<TokenPool>(v8);
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

