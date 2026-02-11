module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_market {
    struct CreatorMarket has key {
        id: 0x2::object::UID,
        creator: address,
        total_supply: u64,
        base_price_micro: u64,
        slope_micro: u64,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CreatorToken has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        shares: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        creator: address,
        base_price_micro: u64,
    }

    struct TokenBought has copy, drop {
        buyer: address,
        market_id: 0x2::object::ID,
        shares: u64,
        cost: u64,
    }

    struct TokenSold has copy, drop {
        seller: address,
        market_id: 0x2::object::ID,
        shares: u64,
        received: u64,
    }

    entry fun buy_tokens(arg0: &mut CreatorMarket, arg1: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformTreasury, arg2: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_treasury::CreatorTreasury, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 2);
        let v0 = calculate_buy_cost(arg0, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg5));
        let v2 = v0 * 200 / 10000;
        let v3 = v0 * 300 / 10000;
        if (v2 > 0) {
            0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::deposit_sui(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v2), arg5));
        };
        if (v3 > 0) {
            0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_treasury::deposit_sui(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v3), arg5));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, v1);
        arg0.total_supply = arg0.total_supply + arg3;
        let v4 = CreatorToken{
            id        : 0x2::object::new(arg5),
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            shares    : arg3,
        };
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::transfer<CreatorToken>(v4, v5);
        let v6 = TokenBought{
            buyer     : v5,
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            shares    : arg3,
            cost      : v0,
        };
        0x2::event::emit<TokenBought>(v6);
    }

    fun calculate_buy_cost(arg0: &CreatorMarket, arg1: u64) : u64 {
        let v0 = arg0.total_supply;
        let v1 = v0 + arg1;
        let v2 = arg0.slope_micro;
        arg0.base_price_micro * arg1 + v2 * v1 * v1 / 2 - v2 * v0 * v0 / 2
    }

    fun calculate_sell_return(arg0: &CreatorMarket, arg1: u64) : u64 {
        let v0 = arg0.total_supply;
        assert!(arg1 <= v0, 1);
        let v1 = v0 - arg1;
        let v2 = arg0.slope_micro;
        arg0.base_price_micro * arg1 + v2 * v0 * v0 / 2 - v2 * v1 * v1 / 2
    }

    entry fun create_market(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorMarket{
            id               : 0x2::object::new(arg2),
            creator          : 0x2::tx_context::sender(arg2),
            total_supply     : 0,
            base_price_micro : arg0,
            slope_micro      : arg1,
            reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CreatorMarket>(v0);
        let v1 = MarketCreated{
            market_id        : 0x2::object::uid_to_inner(&v0.id),
            creator          : 0x2::tx_context::sender(arg2),
            base_price_micro : arg0,
        };
        0x2::event::emit<MarketCreated>(v1);
    }

    public fun get_buy_price(arg0: &CreatorMarket, arg1: u64) : u64 {
        calculate_buy_cost(arg0, arg1)
    }

    public fun get_sell_price(arg0: &CreatorMarket, arg1: u64) : u64 {
        calculate_sell_return(arg0, arg1)
    }

    public fun get_supply(arg0: &CreatorMarket) : u64 {
        arg0.total_supply
    }

    entry fun sell_tokens(arg0: &mut CreatorMarket, arg1: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::PlatformTreasury, arg2: &mut 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_treasury::CreatorTreasury, arg3: CreatorToken, arg4: &mut 0x2::tx_context::TxContext) {
        let CreatorToken {
            id        : v0,
            market_id : _,
            shares    : v2,
        } = arg3;
        0x2::object::delete(v0);
        let v3 = calculate_sell_return(arg0, v2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reserve) >= v3, 1);
        arg0.total_supply = arg0.total_supply - v2;
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, v3), arg4);
        let v5 = v3 * 200 / 10000;
        let v6 = v3 * 300 / 10000;
        if (v5 > 0) {
            0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::platform::deposit_sui(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v4, v5, arg4));
        };
        if (v6 > 0) {
            0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_treasury::deposit_sui(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg4));
        };
        let v7 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v7);
        let v8 = TokenSold{
            seller    : v7,
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            shares    : v2,
            received  : 0x2::coin::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<TokenSold>(v8);
    }

    // decompiled from Move bytecode v6
}

