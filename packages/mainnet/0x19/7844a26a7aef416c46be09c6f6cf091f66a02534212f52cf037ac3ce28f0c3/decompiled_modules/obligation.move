module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::obligation {
    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        deposits: vector<Deposit>,
        deposited_value_usd: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
        allowed_spend_value_usd: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
        card_program_id: 0x2::object::ID,
    }

    struct Deposit has store {
        coin_type: 0x1::type_name::TypeName,
        index: u64,
        total_amount: u64,
        market_value_usd: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
    }

    public fun allowed_spend_value_usd<T0>(arg0: &Obligation<T0>) : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal {
        arg0.allowed_spend_value_usd
    }

    public fun card_program_id<T0>(arg0: &Obligation<T0>) : 0x2::object::ID {
        arg0.card_program_id
    }

    public(friend) fun create_obligation<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Obligation<T0> {
        Obligation<T0>{
            id                      : 0x2::object::new(arg2),
            pool_id                 : arg0,
            deposits                : 0x1::vector::empty<Deposit>(),
            deposited_value_usd     : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0),
            allowed_spend_value_usd : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0),
            card_program_id         : arg1,
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Obligation<T0>, arg1: &0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>, arg2: u64) {
        let v0 = find_or_create_deposit<T0>(arg0, arg1);
        let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
        let v2 = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::div(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::mul(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::price<T0>(arg1), 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg2)), 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::pow(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(10), (0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::decimals<T0>(arg1) as u64)));
        assert!(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::gte(v2, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::min_deposit_amount())), 1);
        v1.total_amount = v1.total_amount + arg2;
        v1.market_value_usd = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::add(v1.market_value_usd, v2);
        arg0.deposited_value_usd = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::add(arg0.deposited_value_usd, v2);
        arg0.allowed_spend_value_usd = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::add(arg0.allowed_spend_value_usd, v2);
    }

    public fun deposit_coin_type(arg0: &Deposit) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun deposit_market_value_usd(arg0: &Deposit) : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal {
        arg0.market_value_usd
    }

    public fun deposit_total_amount(arg0: &Deposit) : u64 {
        arg0.total_amount
    }

    public fun deposited_value_usd<T0>(arg0: &Obligation<T0>) : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal {
        arg0.deposited_value_usd
    }

    public fun deposits<T0>(arg0: &Obligation<T0>) : &vector<Deposit> {
        &arg0.deposits
    }

    public fun find_deposit<T0>(arg0: &Obligation<T0>, arg1: &0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>) : &Deposit {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Deposit>(&arg0.deposits), 0);
        0x1::vector::borrow<Deposit>(&arg0.deposits, v0)
    }

    fun find_deposit_index<T0>(arg0: &Obligation<T0>, arg1: &0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            if (0x1::vector::borrow<Deposit>(&arg0.deposits, v0).index == 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::index<T0>(arg1)) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_or_create_deposit<T0>(arg0: &mut Obligation<T0>, arg1: &0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::Currency<T0>) : u64 {
        let v0 = find_deposit_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            return v0
        };
        let v1 = Deposit{
            coin_type        : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency::coin_type<T0>(arg1),
            index            : v0,
            total_amount     : 0,
            market_value_usd : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0),
        };
        0x1::vector::push_back<Deposit>(&mut arg0.deposits, v1);
        0x1::vector::length<Deposit>(&arg0.deposits) - 1
    }

    public fun pool_id<T0>(arg0: &Obligation<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    // decompiled from Move bytecode v6
}

