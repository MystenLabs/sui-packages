module 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::obligation {
    struct Obligation has drop {
        deposits: vector<Deposit>,
        borrows: vector<Borrow>,
        deposited_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        allowed_borrow_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        unhealthy_borrow_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        unweighted_borrowed_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        weighted_borrowed_value_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        weighted_borrowed_value_upper_bound_usd: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        borrowing_isolated_asset: bool,
    }

    struct Deposit has drop {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        deposited_ctoken_amount: u64,
        market_value: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        user_reward_manager_index: u64,
    }

    struct Borrow has drop {
        coin_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
        borrowed_amount: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        cumulative_borrow_rate: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        market_value: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
    }

    fun compound_debt(arg0: &mut Borrow, arg1: &0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve) {
        let v0 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::cumulative_borrow_rate(arg1);
        arg0.borrowed_amount = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0.borrowed_amount, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v0, arg0.cumulative_borrow_rate));
        arg0.cumulative_borrow_rate = v0;
    }

    fun find_borrow(arg0: &Obligation, arg1: &0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve) : &Borrow {
        let v0 = find_borrow_index(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow>(&arg0.borrows), 2);
        0x1::vector::borrow<Borrow>(&arg0.borrows, v0)
    }

    fun find_borrow_index(arg0: &Obligation, arg1: &0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            if (0x1::vector::borrow<Borrow>(&arg0.borrows, v0).reserve_array_index == 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::array_index(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_deposit(arg0: &Obligation, arg1: &0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve) : &Deposit {
        let v0 = find_deposit_index(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 3);
        0x1::vector::borrow<Deposit>(&arg0.deposits, v0)
    }

    fun find_deposit_index(arg0: &Obligation, arg1: &0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit>(&arg0.deposits, v0).reserve_array_index == 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::array_index(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun from_origin<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>) : Obligation {
        let v0 = 0x1::vector::empty<Borrow>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(arg0))) {
            0x1::vector::push_back<Borrow>(&mut v0, read_borrow(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(arg0), v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<Deposit>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(arg0))) {
            0x1::vector::push_back<Deposit>(&mut v2, read_deposit(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(arg0), v3)));
            v3 = v3 + 1;
        };
        Obligation{
            deposits                                : v2,
            borrows                                 : v0,
            deposited_value_usd                     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(arg0),
            allowed_borrow_value_usd                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(arg0),
            unhealthy_borrow_value_usd              : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unhealthy_borrow_value_usd<T0>(arg0),
            unweighted_borrowed_value_usd           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<T0>(arg0),
            weighted_borrowed_value_usd             : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<T0>(arg0),
            weighted_borrowed_value_upper_bound_usd : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_upper_bound_usd<T0>(arg0),
            borrowing_isolated_asset                : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowing_isolated_asset<T0>(arg0),
        }
    }

    fun is_liquidatable(arg0: &Obligation) : bool {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::gt(arg0.weighted_borrowed_value_usd, arg0.unhealthy_borrow_value_usd)
    }

    public(friend) fun liquidate(arg0: &Obligation, arg1: &vector<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) : (u64, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        assert!(is_liquidatable(arg0), 0);
        let v0 = 0x1::vector::borrow<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(arg1, arg2);
        let v1 = 0x1::vector::borrow<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(arg1, arg3);
        let v2 = find_borrow(arg0, v0);
        let v3 = find_deposit(arg0, v1);
        let v4 = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(v2.market_value, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1))) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(v2.borrowed_amount, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg5))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg0.weighted_borrowed_value_usd, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_percent(20)), v2.market_value), v2.market_value), v2.borrowed_amount), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg5))
        };
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::market_value(v0, v4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::liquidation_bonus(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v1)), 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::protocol_liquidation_fee(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v1)))));
        let (v6, v7) = if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::lt(v3.market_value, v5)) {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v3.market_value, v5)), v3.deposited_ctoken_amount)
        } else {
            (v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v3.deposited_ctoken_amount), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v5, v3.market_value))))
        };
        (v7, v6)
    }

    fun read_borrow(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow) : Borrow {
        Borrow{
            coin_type              : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_coin_type(arg0),
            reserve_array_index    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(arg0),
            borrowed_amount        : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(arg0),
            cumulative_borrow_rate : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_cumulative_borrow_rate(arg0),
            market_value           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_market_value(arg0),
        }
    }

    fun read_deposit(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit) : Deposit {
        Deposit{
            coin_type                 : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_coin_type(arg0),
            reserve_array_index       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(arg0),
            deposited_ctoken_amount   : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(arg0),
            market_value              : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_market_value(arg0),
            user_reward_manager_index : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_user_reward_manager_index(arg0),
        }
    }

    public(friend) fun refresh(arg0: &mut Obligation, arg1: &mut vector<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v4 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
            let v5 = 0x1::vector::borrow_mut<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(arg1, v4.reserve_array_index);
            0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::compound_interest(v5, arg2);
            let v6 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::ctoken_market_value(v5, v4.deposited_ctoken_amount);
            v4.market_value = v6;
            v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v1, v6);
            v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::ctoken_market_value_lower_bound(v5, v4.deposited_ctoken_amount), 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::open_ltv(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v5))));
            v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v6, 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::close_ltv(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v5))));
            v0 = v0 + 1;
        };
        arg0.deposited_value_usd = v1;
        arg0.allowed_borrow_value_usd = v2;
        arg0.unhealthy_borrow_value_usd = v3;
        let v7 = 0;
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v10 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0);
        let v11 = false;
        while (v7 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v12 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v7);
            let v13 = 0x1::vector::borrow_mut<0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::Reserve>(arg1, v12.reserve_array_index);
            0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::compound_interest(v13, arg2);
            compound_debt(v12, v13);
            let v14 = 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::market_value(v13, v12.borrowed_amount);
            v12.market_value = v14;
            v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v8, v14);
            v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v14, 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::borrow_weight(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v13))));
            v10 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(v10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::market_value_upper_bound(v13, v12.borrowed_amount), 0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::borrow_weight(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v13))));
            if (0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve_config::isolated(0xa3292ed7828c45353631d878b0a2b9c89f7a1264752d5c3f27fff602a9eac7a8::reserve::config(v13))) {
                v11 = true;
            };
            v7 = v7 + 1;
        };
        arg0.unweighted_borrowed_value_usd = v8;
        arg0.weighted_borrowed_value_usd = v9;
        arg0.weighted_borrowed_value_upper_bound_usd = v10;
        arg0.borrowing_isolated_asset = v11;
    }

    // decompiled from Move bytecode v6
}

