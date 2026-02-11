module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_market {
    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        creator: address,
    }

    struct TokenBought has copy, drop {
        buyer: address,
        creator: address,
        paid_usde: u64,
        shares_received: u64,
        new_price: u64,
    }

    struct TokenSold has copy, drop {
        seller: address,
        creator: address,
        shares_sold: u64,
        usde_received: u64,
        new_price: u64,
    }

    struct CreatorMarket has key {
        id: 0x2::object::UID,
        creator: address,
        base_price_micro: u64,
        slope_micro: u64,
        total_supply: u64,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        balances: 0x2::table::Table<address, u64>,
    }

    fun buy_cost(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = (arg3 as u128);
        (arg0 as u128) * v0 + (arg1 as u128) * (2 * (arg2 as u128) * v0 + v0 * v0) / 2
    }

    entry fun buy_tokens(arg0: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::CreatorTreasury, arg2: &mut CreatorMarket, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 > 0, 1);
        let v2 = v1 * 200 / 10000;
        let v3 = v1 * 300 / 10000;
        let v4 = v1 - v2 - v3;
        if (v2 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg5));
        };
        if (v3 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg5));
        };
        let v5 = if (arg2.slope_micro == 0) {
            v4 / arg2.base_price_micro
        } else {
            let v6 = (arg2.slope_micro as u128);
            let v7 = 2 * ((arg2.base_price_micro as u128) + (arg2.slope_micro as u128) * (arg2.total_supply as u128));
            let v8 = sqrt(v7 * v7 + 4 * v6 * 2 * (v4 as u128));
            if (v8 > v7) {
                (((v8 - v7) / 2 * v6) as u64)
            } else {
                0
            }
        };
        let v9 = v5;
        while (v9 > 0 && buy_cost(arg2.base_price_micro, arg2.slope_micro, arg2.total_supply, v5) > (v4 as u128)) {
            v9 = v9 - 1;
        };
        assert!(v9 >= arg4, 3);
        assert!(v9 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v10 = get_balance(arg2, v0) + v9;
        set_balance(arg2, v0, v10);
        arg2.total_supply = arg2.total_supply + v9;
        let v11 = TokenBought{
            buyer           : v0,
            creator         : arg2.creator,
            paid_usde       : v1,
            shares_received : v9,
            new_price       : current_price(arg2.base_price_micro, arg2.slope_micro, arg2.total_supply),
        };
        0x2::event::emit<TokenBought>(v11);
    }

    entry fun create_market(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = CreatorMarket{
            id               : 0x2::object::new(arg2),
            creator          : v0,
            base_price_micro : arg0,
            slope_micro      : arg1,
            total_supply     : 0,
            reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            balances         : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::transfer<CreatorMarket>(v1, v0);
        let v2 = MarketCreated{
            market_id : 0x2::object::id<CreatorMarket>(&v1),
            creator   : v0,
        };
        0x2::event::emit<MarketCreated>(v2);
    }

    fun current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 * arg2
    }

    fun get_balance(arg0: &CreatorMarket, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    public fun get_price(arg0: &CreatorMarket) : u64 {
        current_price(arg0.base_price_micro, arg0.slope_micro, arg0.total_supply)
    }

    public fun get_shares(arg0: &CreatorMarket, arg1: address) : u64 {
        get_balance(arg0, arg1)
    }

    public fun get_supply(arg0: &CreatorMarket) : u64 {
        arg0.total_supply
    }

    fun sell_refund(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = (arg2 as u128);
        let v1 = (arg3 as u128);
        let v2 = v0 - v1;
        (arg0 as u128) * v1 + (arg1 as u128) * (v0 * v0 - v2 * v2) / 2
    }

    entry fun sell_tokens(arg0: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::CreatorTreasury, arg2: &mut CreatorMarket, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3 > 0, 1);
        let v1 = get_balance(arg2, v0);
        assert!(v1 >= arg3, 2);
        let v2 = (sell_refund(arg2.base_price_micro, arg2.slope_micro, arg2.total_supply, arg3) as u64);
        let v3 = v2 * 200 / 10000;
        let v4 = v2 * 300 / 10000;
        let v5 = v2 - v3 - v4;
        assert!(v5 >= arg4, 3);
        let v6 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.reserve, v2), arg5);
        if (v3 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v6, v3, arg5));
        };
        if (v4 > 0) {
            0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v6, v4, arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v0);
        set_balance(arg2, v0, v1 - arg3);
        arg2.total_supply = arg2.total_supply - arg3;
        let v7 = TokenSold{
            seller        : v0,
            creator       : arg2.creator,
            shares_sold   : arg3,
            usde_received : v5,
            new_price     : current_price(arg2.base_price_micro, arg2.slope_micro, arg2.total_supply),
        };
        0x2::event::emit<TokenSold>(v7);
    }

    fun set_balance(arg0: &mut CreatorMarket, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.balances, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, arg1, arg2);
        };
    }

    fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

