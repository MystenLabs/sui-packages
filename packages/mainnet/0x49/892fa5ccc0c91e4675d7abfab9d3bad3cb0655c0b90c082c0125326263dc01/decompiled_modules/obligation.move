module 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::obligation {
    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        deposits: vector<Deposit<T0>>,
        borrows: vector<Borrow<T0>>,
        deposited_value_usd: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        allowed_borrow_value_usd: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        unhealthy_borrow_value_usd: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        unweighted_borrowed_value_usd: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        weighted_borrowed_value_usd: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        weighted_borrowed_value_upper_bound_usd: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
    }

    struct Deposit<phantom T0> has store {
        reserve_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        deposited_ctoken_amount: u64,
        market_value: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
    }

    struct Borrow<phantom T0> has store {
        reserve_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        borrowed_amount: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        cumulative_borrow_rate: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
        market_value: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal,
    }

    public(friend) fun borrow<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg2: u64) {
        let v0 = find_or_add_borrow<T0>(arg0, arg1);
        v0.borrowed_amount = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v0.borrowed_amount, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(arg2));
        let v1 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value<T0>(arg1, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(arg2));
        v0.market_value = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v0.market_value, v1);
        arg0.unweighted_borrowed_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.unweighted_borrowed_value_usd, v1);
        arg0.weighted_borrowed_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.weighted_borrowed_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v1, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
        arg0.weighted_borrowed_value_upper_bound_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.weighted_borrowed_value_upper_bound_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value_upper_bound<T0>(arg1, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(arg2)), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
        assert!(is_healthy<T0>(arg0), 0);
    }

    fun compound_interest<T0>(arg0: &mut Borrow<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) {
        let v0 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::cumulative_borrow_rate<T0>(arg1);
        arg0.borrowed_amount = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(arg0.borrowed_amount, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::div(v0, arg0.cumulative_borrow_rate));
        arg0.cumulative_borrow_rate = v0;
    }

    public(friend) fun create_obligation<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Obligation<T0> {
        Obligation<T0>{
            id                                      : 0x2::object::new(arg1),
            owner                                   : arg0,
            deposits                                : 0x1::vector::empty<Deposit<T0>>(),
            borrows                                 : 0x1::vector::empty<Borrow<T0>>(),
            deposited_value_usd                     : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
            allowed_borrow_value_usd                : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
            unhealthy_borrow_value_usd              : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
            unweighted_borrowed_value_usd           : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
            weighted_borrowed_value_usd             : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
            weighted_borrowed_value_upper_bound_usd : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg2: u64) {
        let v0 = find_or_add_deposit<T0>(arg0, arg1);
        v0.deposited_ctoken_amount = v0.deposited_ctoken_amount + arg2;
        let v1 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::ctoken_market_value<T0>(arg1, arg2);
        v0.market_value = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v0.market_value, v1);
        arg0.deposited_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.deposited_value_usd, v1);
        arg0.allowed_borrow_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.allowed_borrow_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::ctoken_market_value_lower_bound<T0>(arg1, arg2), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::open_ltv(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
        arg0.unhealthy_borrow_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.unhealthy_borrow_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v1, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::close_ltv(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
    }

    fun find_borrow<T0>(arg0: &Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : &Borrow<T0> {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows), 2);
        0x1::vector::borrow<Borrow<T0>>(&arg0.borrows, v0)
    }

    fun find_borrow_index<T0>(arg0: &Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows)) {
            if (0x1::vector::borrow<Borrow<T0>>(&arg0.borrows, v0).reserve_id == 0x2::object::id<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_borrow_mut<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : &mut Borrow<T0> {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows), 2);
        0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, v0)
    }

    fun find_deposit<T0>(arg0: &Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : &Deposit<T0> {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits), 3);
        0x1::vector::borrow<Deposit<T0>>(&arg0.deposits, v0)
    }

    fun find_deposit_index<T0>(arg0: &Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit<T0>>(&arg0.deposits, v0).reserve_id == 0x2::object::id<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_deposit_mut<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : &mut Deposit<T0> {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits), 3);
        0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, v0)
    }

    fun find_or_add_borrow<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : &mut Borrow<T0> {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows)) {
            return 0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, v0)
        };
        let v1 = Borrow<T0>{
            reserve_id             : 0x2::object::id<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg1),
            coin_type              : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::coin_type<T0>(arg1),
            borrowed_amount        : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
            cumulative_borrow_rate : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::cumulative_borrow_rate<T0>(arg1),
            market_value           : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
        };
        0x1::vector::push_back<Borrow<T0>>(&mut arg0.borrows, v1);
        0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, 0x1::vector::length<Borrow<T0>>(&arg0.borrows) - 1)
    }

    fun find_or_add_deposit<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>) : &mut Deposit<T0> {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits)) {
            return 0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, v0)
        };
        let v1 = Deposit<T0>{
            reserve_id              : 0x2::object::id<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg1),
            coin_type               : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::coin_type<T0>(arg1),
            deposited_ctoken_amount : 0,
            market_value            : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0),
        };
        0x1::vector::push_back<Deposit<T0>>(&mut arg0.deposits, v1);
        0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, 0x1::vector::length<Deposit<T0>>(&arg0.deposits) - 1)
    }

    fun find_reserve_by_id<T0>(arg0: &mut vector<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>, arg1: 0x2::object::ID) : &mut 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0> {
        let v0 = find_reserve_index_by_id<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg0), 0);
        0x1::vector::borrow_mut<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg0, v0)
    }

    fun find_reserve_index_by_id<T0>(arg0: &vector<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg0)) {
            if (0x2::object::id<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(0x1::vector::borrow<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>(arg0, v0)) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun is_healthy<T0>(arg0: &Obligation<T0>) : bool {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::le(arg0.weighted_borrowed_value_upper_bound_usd, arg0.allowed_borrow_value_usd)
    }

    public fun is_unhealthy<T0>(arg0: &Obligation<T0>) : bool {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::gt(arg0.weighted_borrowed_value_usd, arg0.unhealthy_borrow_value_usd)
    }

    public(friend) fun liquidate<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg2: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg3: u64) : (u64, u64) {
        assert!(is_unhealthy<T0>(arg0), 1);
        let v0 = find_borrow<T0>(arg0, arg1);
        let v1 = find_deposit<T0>(arg0, arg2);
        let v2 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::min(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::div(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::min(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(arg0.weighted_borrowed_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent(20)), v0.market_value), v0.market_value), v0.borrowed_amount), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(arg3));
        let v3 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value<T0>(arg1, v2), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(1), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::liquidation_bonus(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg2))));
        let (v4, v5, v6) = if (0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::lt(v1.market_value, v3)) {
            let v7 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v2, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::div(v1.market_value, v3));
            (0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::ceil(v7), v7, v1.deposited_ctoken_amount)
        } else {
            (0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::ceil(v2), v2, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::floor(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(v1.deposited_ctoken_amount), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::div(v3, v1.market_value))))
        };
        repay<T0>(arg0, arg1, v5);
        withdraw_unchecked<T0>(arg0, arg2, v6);
        (v6, v4)
    }

    public(friend) fun refresh<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0);
        let v2 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0);
        let v3 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0);
        while (v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits)) {
            let v4 = 0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, v0);
            let v5 = find_reserve_by_id<T0>(arg1, v4.reserve_id);
            0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::compound_interest<T0>(v5, arg2);
            0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::assert_price_is_fresh<T0>(v5, arg2);
            let v6 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::ctoken_market_value<T0>(v5, v4.deposited_ctoken_amount);
            v4.market_value = v6;
            v1 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v1, v6);
            v2 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v2, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::ctoken_market_value_lower_bound<T0>(v5, v4.deposited_ctoken_amount), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::open_ltv(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(v5))));
            v3 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v3, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v6, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::close_ltv(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(v5))));
            v0 = v0 + 1;
        };
        arg0.deposited_value_usd = v1;
        arg0.allowed_borrow_value_usd = v2;
        arg0.unhealthy_borrow_value_usd = v3;
        let v7 = 0;
        let v8 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0);
        let v9 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0);
        let v10 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0);
        while (v7 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows)) {
            let v11 = 0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, v7);
            let v12 = find_reserve_by_id<T0>(arg1, v11.reserve_id);
            0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::compound_interest<T0>(v12, arg2);
            0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::assert_price_is_fresh<T0>(v12, arg2);
            compound_interest<T0>(v11, v12);
            let v13 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value<T0>(v12, v11.borrowed_amount);
            v11.market_value = v13;
            v8 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v8, v13);
            v9 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v9, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v13, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(v12))));
            v10 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v10, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value_upper_bound<T0>(v12, v11.borrowed_amount), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(v12))));
            v7 = v7 + 1;
        };
        arg0.unweighted_borrowed_value_usd = v8;
        arg0.weighted_borrowed_value_usd = v9;
        arg0.weighted_borrowed_value_upper_bound_usd = v10;
    }

    public(friend) fun repay<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg2: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal) {
        let v0 = find_borrow_mut<T0>(arg0, arg1);
        let v1 = v0.borrowed_amount;
        compound_interest<T0>(v0, arg1);
        let v2 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(v0.borrowed_amount, v1);
        v0.borrowed_amount = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(v0.borrowed_amount, arg2);
        if (0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::le(v2, arg2)) {
            let v3 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg2, v2);
            let v4 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value<T0>(arg1, v3);
            v0.market_value = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(v0.market_value, v4);
            arg0.unweighted_borrowed_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg0.unweighted_borrowed_value_usd, v4);
            arg0.weighted_borrowed_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg0.weighted_borrowed_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v4, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
            arg0.weighted_borrowed_value_upper_bound_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg0.weighted_borrowed_value_upper_bound_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value_upper_bound<T0>(arg1, v3), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
        } else {
            let v5 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(v2, arg2);
            let v6 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value<T0>(arg1, v5);
            v0.market_value = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v0.market_value, v6);
            arg0.unweighted_borrowed_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.unweighted_borrowed_value_usd, v6);
            arg0.weighted_borrowed_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.weighted_borrowed_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v6, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
            arg0.weighted_borrowed_value_upper_bound_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(arg0.weighted_borrowed_value_upper_bound_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::market_value_upper_bound<T0>(arg1, v5), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::borrow_weight(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
        };
    }

    public(friend) fun withdraw<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg2: u64) {
        withdraw_unchecked<T0>(arg0, arg1, arg2);
        assert!(is_healthy<T0>(arg0), 0);
    }

    fun withdraw_unchecked<T0>(arg0: &mut Obligation<T0>, arg1: &0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::Reserve<T0>, arg2: u64) {
        let v0 = find_deposit_mut<T0>(arg0, arg1);
        let v1 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::ctoken_market_value<T0>(arg1, arg2);
        v0.market_value = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(v0.market_value, v1);
        v0.deposited_ctoken_amount = v0.deposited_ctoken_amount - arg2;
        arg0.deposited_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg0.deposited_value_usd, v1);
        arg0.allowed_borrow_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg0.allowed_borrow_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::ctoken_market_value_lower_bound<T0>(arg1, arg2), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::open_ltv(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
        arg0.unhealthy_borrow_value_usd = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg0.unhealthy_borrow_value_usd, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(v1, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config::close_ltv(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve::config<T0>(arg1))));
    }

    // decompiled from Move bytecode v6
}

