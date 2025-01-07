module 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::obligation {
    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        deposits: vector<Deposit<T0>>,
        borrows: vector<Borrow<T0>>,
        balances: 0x2::bag::Bag,
        deposited_value_usd: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
        allowed_borrow_value_usd: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
        unhealthy_borrow_value_usd: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
        unweighted_borrowed_value_usd: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
        weighted_borrowed_value_usd: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
    }

    struct Deposit<phantom T0> has store {
        reserve_id: u64,
        deposited_ctoken_amount: u64,
        market_value: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
    }

    struct Borrow<phantom T0> has store {
        reserve_id: u64,
        borrowed_amount: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
        cumulative_borrow_rate: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
        market_value: 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::Decimal,
    }

    struct Key<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RefreshedTicket has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0, T1>(arg0: RefreshedTicket, arg1: &mut Obligation<T0>, arg2: &0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) {
        let v0 = find_or_add_borrow<T0>(arg1, arg3);
        v0.borrowed_amount = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(v0.borrowed_amount, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(arg5));
        let v1 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::market_value<T0>(arg2, arg4, v0.borrowed_amount);
        let v2 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(v1, v0.market_value);
        v0.market_value = v1;
        arg1.unweighted_borrowed_value_usd = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(arg1.unweighted_borrowed_value_usd, v2);
        arg1.weighted_borrowed_value_usd = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(arg1.weighted_borrowed_value_usd, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v2, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::borrow_weight<T0>(arg2)));
        assert!(is_healthy<T0>(arg1), 0);
        let RefreshedTicket {  } = arg0;
    }

    fun add_to_balance_bag<T0, T1>(arg0: &mut Obligation<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = Key<T1>{dummy_field: false};
        if (0x2::bag::contains<Key<T1>>(&arg0.balances, v0)) {
            let v1 = Key<T1>{dummy_field: false};
            0x2::balance::join<T1>(0x2::bag::borrow_mut<Key<T1>, 0x2::balance::Balance<T1>>(&mut arg0.balances, v1), arg1);
        } else {
            let v2 = Key<T1>{dummy_field: false};
            0x2::bag::add<Key<T1>, 0x2::balance::Balance<T1>>(&mut arg0.balances, v2, arg1);
        };
    }

    fun compound_interest<T0>(arg0: &mut Borrow<T0>, arg1: &0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>) {
        let v0 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::cumulative_borrow_rate<T0>(arg1);
        let v1 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::div(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::cumulative_borrow_rate<T0>(arg1), v0);
        assert!(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::ge(v1, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(1)), 0);
        arg0.borrowed_amount = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(arg0.borrowed_amount, v1);
        arg0.cumulative_borrow_rate = v0;
    }

    public(friend) fun create_obligation<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Obligation<T0> {
        Obligation<T0>{
            id                            : 0x2::object::new(arg1),
            owner                         : arg0,
            deposits                      : 0x1::vector::empty<Deposit<T0>>(),
            borrows                       : 0x1::vector::empty<Borrow<T0>>(),
            balances                      : 0x2::bag::new(arg1),
            deposited_value_usd           : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
            allowed_borrow_value_usd      : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
            unhealthy_borrow_value_usd    : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
            unweighted_borrowed_value_usd : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
            weighted_borrowed_value_usd   : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
        }
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Obligation<T0>, arg1: u64, arg2: 0x2::balance::Balance<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>) {
        let v0 = find_or_add_deposit<T0>(arg0, arg1);
        v0.deposited_ctoken_amount = v0.deposited_ctoken_amount + 0x2::balance::value<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>(&arg2);
        add_to_balance_bag<T0, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>(arg0, arg2);
    }

    fun find_borrow<T0>(arg0: &Obligation<T0>, arg1: u64) : &Borrow<T0> {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows), 2);
        0x1::vector::borrow<Borrow<T0>>(&arg0.borrows, v0)
    }

    fun find_borrow_index<T0>(arg0: &Obligation<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows)) {
            if (0x1::vector::borrow<Borrow<T0>>(&arg0.borrows, v0).reserve_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_borrow_mut<T0>(arg0: &mut Obligation<T0>, arg1: u64) : &mut Borrow<T0> {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows), 2);
        0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, v0)
    }

    fun find_deposit<T0>(arg0: &Obligation<T0>, arg1: u64) : &Deposit<T0> {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits), 3);
        0x1::vector::borrow<Deposit<T0>>(&arg0.deposits, v0)
    }

    fun find_deposit_index<T0>(arg0: &Obligation<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit<T0>>(&arg0.deposits, v0).reserve_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_deposit_mut<T0>(arg0: &mut Obligation<T0>, arg1: u64) : &mut Deposit<T0> {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits), 3);
        0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, v0)
    }

    fun find_or_add_borrow<T0>(arg0: &mut Obligation<T0>, arg1: u64) : &mut Borrow<T0> {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows)) {
            return 0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, v0)
        };
        let v1 = Borrow<T0>{
            reserve_id             : arg1,
            borrowed_amount        : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
            cumulative_borrow_rate : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(1),
            market_value           : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
        };
        0x1::vector::push_back<Borrow<T0>>(&mut arg0.borrows, v1);
        0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, 0x1::vector::length<Borrow<T0>>(&arg0.borrows) - 1)
    }

    fun find_or_add_deposit<T0>(arg0: &mut Obligation<T0>, arg1: u64) : &mut Deposit<T0> {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits)) {
            return 0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, v0)
        };
        let v1 = Deposit<T0>{
            reserve_id              : arg1,
            deposited_ctoken_amount : 0,
            market_value            : 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0),
        };
        0x1::vector::push_back<Deposit<T0>>(&mut arg0.deposits, v1);
        0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, 0x1::vector::length<Deposit<T0>>(&arg0.deposits) - 1)
    }

    fun health<T0>(arg0: &Obligation<T0>) : u64 {
        if (0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::gt(arg0.unweighted_borrowed_value_usd, arg0.unhealthy_borrow_value_usd)) {
            return 2
        };
        if (0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::gt(arg0.weighted_borrowed_value_usd, arg0.allowed_borrow_value_usd)) {
            return 1
        };
        0
    }

    public fun is_healthy<T0>(arg0: &Obligation<T0>) : bool {
        health<T0>(arg0) == 0
    }

    public fun is_unhealthy<T0>(arg0: &Obligation<T0>) : bool {
        health<T0>(arg0) == 2
    }

    public(friend) fun liquidate<T0, T1, T2>(arg0: RefreshedTicket, arg1: &mut Obligation<T0>, arg2: &0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>, arg3: u64, arg4: &0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::balance::Balance<T1>) : (0x2::balance::Balance<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T2>>, u64) {
        assert!(is_unhealthy<T0>(arg1), 1);
        let v0 = find_deposit<T0>(arg1, arg5);
        let v1 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::min(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(find_borrow<T0>(arg1, arg3).borrowed_amount, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from_percent(20)), 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0x2::balance::value<T1>(arg7)));
        let v2 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::market_value<T0>(arg2, arg6, v1), 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(1), 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::liquidation_bonus<T0>(arg4)));
        let (v3, v4, v5) = if (0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::lt(v0.market_value, v2)) {
            let v6 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v1, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::div(v0.market_value, v2));
            let v3 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::ceil(v6);
            (v3, v6, v0.deposited_ctoken_amount)
        } else {
            let v3 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::ceil(v1);
            (v3, v1, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::floor(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(v0.deposited_ctoken_amount), 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::div(v2, v0.market_value))))
        };
        let v7 = find_borrow_mut<T0>(arg1, arg3);
        v7.borrowed_amount = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(v7.borrowed_amount, v4);
        let v8 = find_deposit_mut<T0>(arg1, arg5);
        v8.deposited_ctoken_amount = v8.deposited_ctoken_amount - v5;
        let v9 = Key<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T2>>{dummy_field: false};
        let v10 = 0x2::balance::split<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T2>>(0x2::bag::borrow_mut<Key<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T2>>, 0x2::balance::Balance<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T2>>>(&mut arg1.balances, v9), v5);
        let v11 = b"hi";
        0x1::debug::print<vector<u8>>(&v11);
        0x1::debug::print<u64>(&v3);
        0x1::debug::print<0x2::balance::Balance<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T2>>>(&v10);
        (v10, v3)
    }

    public(friend) fun refresh<T0>(arg0: &mut Obligation<T0>, arg1: &mut vector<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>>, arg2: &0x2::clock::Clock) : RefreshedTicket {
        let v0 = 0;
        let v1 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0);
        let v2 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0);
        let v3 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0);
        while (v0 < 0x1::vector::length<Deposit<T0>>(&arg0.deposits)) {
            let v4 = 0x1::vector::borrow_mut<Deposit<T0>>(&mut arg0.deposits, v0);
            let v5 = 0x1::vector::borrow_mut<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>>(arg1, v4.reserve_id);
            0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::compound_interest<T0>(v5, arg2);
            let v6 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::market_value<T0>(v5, arg2, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(v4.deposited_ctoken_amount), 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::ctoken_ratio<T0>(v5)));
            v4.market_value = v6;
            v1 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(v1, v6);
            v2 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(v2, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v6, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::open_ltv<T0>(v5)));
            v3 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(v3, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v6, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::close_ltv<T0>(v5)));
            v0 = v0 + 1;
        };
        arg0.deposited_value_usd = v1;
        arg0.allowed_borrow_value_usd = v2;
        arg0.unhealthy_borrow_value_usd = v3;
        let v7 = 0;
        let v8 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0);
        let v9 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(0);
        while (v7 < 0x1::vector::length<Borrow<T0>>(&arg0.borrows)) {
            let v10 = 0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, v7);
            let v11 = 0x1::vector::borrow_mut<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>>(arg1, v10.reserve_id);
            0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::compound_interest<T0>(v11, arg2);
            compound_interest<T0>(v10, v11);
            let v12 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::market_value<T0>(v11, arg2, v10.borrowed_amount);
            v10.market_value = v12;
            v8 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(v8, v12);
            v9 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::add(v9, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v12, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::borrow_weight<T0>(v11)));
            v7 = v7 + 1;
        };
        arg0.unweighted_borrowed_value_usd = v8;
        arg0.weighted_borrowed_value_usd = v9;
        RefreshedTicket{dummy_field: false}
    }

    public(friend) fun repay<T0>(arg0: &mut Obligation<T0>, arg1: &0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>, arg2: u64, arg3: u64) {
        let v0 = 0x1::vector::borrow_mut<Borrow<T0>>(&mut arg0.borrows, find_borrow_index<T0>(arg0, arg2));
        compound_interest<T0>(v0, arg1);
        v0.borrowed_amount = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(v0.borrowed_amount, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(arg3));
    }

    public(friend) fun withdraw<T0, T1>(arg0: RefreshedTicket, arg1: &mut Obligation<T0>, arg2: &0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::Reserve<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) : 0x2::balance::Balance<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>> {
        let v0 = 0x1::vector::borrow_mut<Deposit<T0>>(&mut arg1.deposits, find_deposit_index<T0>(arg1, arg3));
        let v1 = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::market_value<T0>(arg2, arg4, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::from(arg5), 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::ctoken_ratio<T0>(arg2)));
        v0.market_value = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(v0.market_value, v1);
        v0.deposited_ctoken_amount = v0.deposited_ctoken_amount - arg5;
        arg1.deposited_value_usd = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(arg1.deposited_value_usd, v1);
        arg1.allowed_borrow_value_usd = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(arg1.allowed_borrow_value_usd, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v1, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::open_ltv<T0>(arg2)));
        arg1.unhealthy_borrow_value_usd = 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::sub(arg1.unhealthy_borrow_value_usd, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::decimal::mul(v1, 0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::close_ltv<T0>(arg2)));
        assert!(is_healthy<T0>(arg1), 0);
        let RefreshedTicket {  } = arg0;
        let v2 = Key<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>{dummy_field: false};
        0x2::balance::split<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>(0x2::bag::borrow_mut<Key<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>, 0x2::balance::Balance<0xd4b22ab40c4e3ef2f90cef9432bde18bea223d06644a111921383821344cb340::reserve::CToken<T0, T1>>>(&mut arg1.balances, v2), arg5)
    }

    // decompiled from Move bytecode v6
}

