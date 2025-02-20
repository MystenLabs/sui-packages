module 0x4d861d439543e657e586c8914dc628e11782008e227661284abab77e8931ad1b::token_factory {
    struct Token has drop {
        dummy_field: bool,
    }

    struct TokenConfig has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        logo: 0x1::string::String,
        total_supply: u64,
        mintable: bool,
        burnable: bool,
        blacklist: vector<address>,
        treasury_cap: 0x2::coin::TreasuryCap<Token>,
    }

    struct LiquidityPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_t1: 0x2::balance::Balance<T0>,
        reserve_t2: 0x2::balance::Balance<T1>,
        total_lp_supply: u64,
        lp_treasury: 0x2::coin::TreasuryCap<LPToken<T0, T1>>,
    }

    struct LPToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct FactoryAdmin has store, key {
        id: 0x2::object::UID,
        fee_address: address,
        swap_fee_bp: u64,
    }

    struct TokenCreated has copy, drop {
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        supply: u64,
    }

    struct SwapEvent has copy, drop {
        trader: address,
        amount_in: u64,
        amount_out: u64,
    }

    public entry fun swap<T0: drop, T1: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut LiquidityPool<T0, T1>, arg3: &TokenConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x1::vector::contains<address>(&arg3.blacklist, &v0), 4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 3);
        let v2 = 0x2::balance::value<T1>(&arg2.reserve_t2);
        assert!(v2 > 0, 2);
        let v3 = v1 * 9990 / 10000;
        let v4 = (((v3 as u128) * (v2 as u128) / ((0x2::balance::value<T0>(&arg2.reserve_t1) as u128) + (v3 as u128))) as u64);
        assert!(v4 >= arg1, 3);
        assert!(v2 >= v4, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1 - v3, arg4), @0x152fa772d358c3bd6fb299e4ef66d32c849a040ceeee64554caccd0b464094c1);
        0x2::balance::join<T0>(&mut arg2.reserve_t1, 0x2::coin::into_balance<T0>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.reserve_t2, v4), arg4), v0);
        let v5 = SwapEvent{
            trader     : v0,
            amount_in  : v1,
            amount_out : v4,
        };
        0x2::event::emit<SwapEvent>(v5);
    }

    public entry fun burn(arg0: &mut TokenConfig, arg1: 0x2::coin::Coin<Token>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.burnable, 1);
        0x2::coin::burn<Token>(&mut arg0.treasury_cap, arg1);
    }

    public entry fun mint(arg0: &mut TokenConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mintable, 1);
        assert!(0x2::tx_context::sender(arg2) == 0x2::object::uid_to_address(&arg0.id), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<Token>>(0x2::coin::mint<Token>(&mut arg0.treasury_cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun add_liquidity<T0: drop, T1: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut LiquidityPool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 3);
        let v2 = if (arg2.total_lp_supply == 0) {
            (((v0 as u128) * (v1 as u128)) as u64)
        } else {
            let v3 = v0 * arg2.total_lp_supply / 0x2::balance::value<T0>(&arg2.reserve_t1);
            let v4 = v1 * arg2.total_lp_supply / 0x2::balance::value<T1>(&arg2.reserve_t2);
            if (v3 < v4) {
                v3
            } else {
                v4
            }
        };
        0x2::balance::join<T0>(&mut arg2.reserve_t1, 0x2::coin::into_balance<T0>(arg0));
        0x2::balance::join<T1>(&mut arg2.reserve_t2, 0x2::coin::into_balance<T1>(arg1));
        arg2.total_lp_supply = arg2.total_lp_supply + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LPToken<T0, T1>>>(0x2::coin::mint<LPToken<T0, T1>>(&mut arg2.lp_treasury, v2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_token(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: bool, arg6: vector<address>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= 1000000000, 0);
        assert!(0x1::vector::length<address>(&arg6) <= 500, 6);
        assert!(0x1::vector::length<u8>(&arg0) <= 1024, 6);
        assert!(0x1::vector::length<u8>(&arg1) <= 1024, 6);
        assert!(0x1::vector::length<u8>(&arg2) <= 1024, 6);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = Token{dummy_field: false};
        let (v2, v3) = 0x2::coin::create_currency<Token>(v1, 9, arg1, arg0, b"Custom token created via token factory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg2)), arg8);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Token>>(v3);
        let v5 = LPToken<Token, 0x2::sui::SUI>{dummy_field: false};
        let (v6, v7) = 0x2::coin::create_currency<LPToken<Token, 0x2::sui::SUI>>(v5, 9, b"LP", b"Liquidity Pool Token", b"", 0x1::option::none<0x2::url::Url>(), arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPToken<Token, 0x2::sui::SUI>>>(v7);
        let v8 = TokenConfig{
            id           : 0x2::object::new(arg8),
            name         : 0x1::string::utf8(arg0),
            symbol       : 0x1::string::utf8(arg1),
            logo         : 0x1::string::utf8(arg2),
            total_supply : arg3,
            mintable     : arg4,
            burnable     : arg5,
            blacklist    : arg6,
            treasury_cap : v4,
        };
        let v9 = LiquidityPool<Token, 0x2::sui::SUI>{
            id              : 0x2::object::new(arg8),
            reserve_t1      : 0x2::coin::mint_balance<Token>(&mut v4, arg3 - arg3 / 10),
            reserve_t2      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_lp_supply : 0,
            lp_treasury     : v6,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, @0x152fa772d358c3bd6fb299e4ef66d32c849a040ceeee64554caccd0b464094c1);
        let v10 = TokenCreated{
            creator : v0,
            name    : 0x1::string::utf8(arg0),
            symbol  : 0x1::string::utf8(arg1),
            supply  : arg3,
        };
        0x2::event::emit<TokenCreated>(v10);
        0x2::transfer::public_transfer<TokenConfig>(v8, v0);
        0x2::transfer::public_transfer<LiquidityPool<Token, 0x2::sui::SUI>>(v9, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<Token>>(0x2::coin::mint<Token>(&mut v4, arg3 / 10, arg8), v0);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryAdmin{
            id          : 0x2::object::new(arg0),
            fee_address : @0x152fa772d358c3bd6fb299e4ef66d32c849a040ceeee64554caccd0b464094c1,
            swap_fee_bp : 10,
        };
        0x2::transfer::public_transfer<FactoryAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_blacklist(arg0: &mut TokenConfig, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x2::object::uid_to_address(&arg0.id), 1);
        assert!(0x1::vector::length<address>(&arg0.blacklist) <= 500, 6);
        if (arg2) {
            0x1::vector::push_back<address>(&mut arg0.blacklist, arg1);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.blacklist, &arg1);
            if (v0) {
                0x1::vector::remove<address>(&mut arg0.blacklist, v1);
            };
        };
    }

    public entry fun update_fee_address(arg0: &mut FactoryAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.fee_address, 1);
        arg0.fee_address = arg1;
    }

    public entry fun update_swap_fee(arg0: &mut FactoryAdmin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.fee_address, 1);
        arg0.swap_fee_bp = arg1;
    }

    // decompiled from Move bytecode v6
}

