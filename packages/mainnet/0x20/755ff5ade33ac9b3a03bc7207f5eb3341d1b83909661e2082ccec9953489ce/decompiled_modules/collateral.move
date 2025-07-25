module 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::collateral {
    struct Collateral has store {
        balances: 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::Balances,
    }

    public fun destroy_empty(arg0: Collateral) {
        let Collateral { balances: v0 } = arg0;
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::destroy_empty(v0);
    }

    public fun is_empty(arg0: &Collateral) : bool {
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::is_empty(&arg0.balances)
    }

    public fun deposit<T0>(arg0: &mut Collateral, arg1: 0x2::balance::Balance<T0>) {
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::deposit<T0>(&mut arg0.balances, arg1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Collateral {
        Collateral{balances: 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::new(arg0)}
    }

    public fun partial_withdraw<T0>(arg0: &mut Collateral, arg1: u64) : 0x2::balance::Balance<T0> {
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::partial_withdraw<T0>(&mut arg0.balances, arg1)
    }

    public fun value<T0>(arg0: &Collateral) : u64 {
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::value<T0>(&arg0.balances)
    }

    public fun withdraw<T0>(arg0: &mut Collateral) : 0x2::balance::Balance<T0> {
        0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::withdraw<T0>(&mut arg0.balances)
    }

    public fun calc_value(arg0: &Collateral, arg1: &mut 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::trusted_prices::TrustedPriceData, arg2: &0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>) : u64 {
        let v0 = 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::list(&arg0.balances);
        let v1 = 0;
        while (!0x1::vector::is_empty<0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::BalanceItem>(&v0)) {
            let (v2, v3) = 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::into_values(0x1::vector::pop_back<0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::BalanceItem>(&mut v0));
            let v4 = 0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::trusted_prices::pull_raw_price(arg1, v2);
            let v5 = if (0x2::table::contains<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg2, v2)) {
                *0x2::table::borrow<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg2, v2)
            } else {
                0x1::uq32_32::from_int(0)
            };
            v1 = v1 + 0x1::uq32_32::int_mul(0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::price::calc_value(&v4, v3), v5);
        };
        0x1::vector::destroy_empty<0x20755ff5ade33ac9b3a03bc7207f5eb3341d1b83909661e2082ccec9953489ce::balances::BalanceItem>(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

