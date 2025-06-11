module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::currency {
    struct Currency<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        price: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
        decimals: u8,
        price_id: vector<u8>,
        withdraw_fee_bps: u64,
        index: u64,
    }

    struct Balances<phantom T0, phantom T1> has store {
        fees: 0x2::balance::Balance<T1>,
        total_amount: 0x2::balance::Balance<T1>,
    }

    struct CurrencyBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun add_balance<T0, T1>(arg0: &mut Currency<T0>, arg1: 0x2::balance::Balance<T1>) : u64 {
        let v0 = CurrencyBalanceKey{dummy_field: false};
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<CurrencyBalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).total_amount, arg1)
    }

    public(friend) fun admin_withdraw<T0, T1>(arg0: &mut Currency<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = CurrencyBalanceKey{dummy_field: false};
        0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<CurrencyBalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).total_amount, arg1)
    }

    public fun balances<T0, T1>(arg0: &Currency<T0>) : &Balances<T0, T1> {
        let v0 = CurrencyBalanceKey{dummy_field: false};
        0x2::dynamic_field::borrow<CurrencyBalanceKey, Balances<T0, T1>>(&arg0.id, v0)
    }

    public fun coin_type<T0>(arg0: &Currency<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun create_currency<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Currency<T0> {
        let (v0, v1) = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::oracle::get_pyth_price_and_price_id(arg2, arg5);
        let v2 = Currency<T0>{
            id               : 0x2::object::new(arg6),
            pool_id          : arg0,
            coin_type        : 0x1::type_name::get<T1>(),
            price            : v0,
            decimals         : arg4,
            price_id         : v1,
            withdraw_fee_bps : arg3,
            index            : arg1,
        };
        let v3 = CurrencyBalanceKey{dummy_field: false};
        let v4 = Balances<T0, T1>{
            fees         : 0x2::balance::zero<T1>(),
            total_amount : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_field::add<CurrencyBalanceKey, Balances<T0, T1>>(&mut v2.id, v3, v4);
        v2
    }

    public fun decimals<T0>(arg0: &Currency<T0>) : u8 {
        arg0.decimals
    }

    public fun index<T0>(arg0: &Currency<T0>) : u64 {
        arg0.index
    }

    public fun price<T0>(arg0: &Currency<T0>) : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal {
        arg0.price
    }

    public fun total_amount<T0, T1>(arg0: &Currency<T0>) : u64 {
        0x2::balance::value<T1>(&balances<T0, T1>(arg0).total_amount)
    }

    // decompiled from Move bytecode v6
}

