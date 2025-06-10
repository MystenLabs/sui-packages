module 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::collateral {
    struct Collateral has store {
        balances: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::Balances,
    }

    public fun destroy_empty(arg0: Collateral) {
        let Collateral { balances: v0 } = arg0;
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::destroy_empty(v0);
    }

    public fun is_empty(arg0: &Collateral) : bool {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::is_empty(&arg0.balances)
    }

    public fun deposit<T0>(arg0: &mut Collateral, arg1: 0x2::balance::Balance<T0>) {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::deposit<T0>(&mut arg0.balances, arg1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Collateral {
        Collateral{balances: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::new(arg0)}
    }

    public fun partial_withdraw<T0>(arg0: &mut Collateral, arg1: u64) : 0x2::balance::Balance<T0> {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::partial_withdraw<T0>(&mut arg0.balances, arg1)
    }

    public fun value<T0>(arg0: &Collateral) : u64 {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::value<T0>(&arg0.balances)
    }

    public fun withdraw<T0>(arg0: &mut Collateral) : 0x2::balance::Balance<T0> {
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::withdraw<T0>(&mut arg0.balances)
    }

    public fun calc_value<T0>(arg0: &Collateral, arg1: &mut 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData, arg2: &0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>) : u64 {
        calc_value_raw(arg0, 0x1::type_name::get<T0>(), arg1, arg2)
    }

    public fun calc_value_raw(arg0: &Collateral, arg1: 0x1::type_name::TypeName, arg2: &mut 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData, arg3: &0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>) : u64 {
        let v0 = 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::list(&arg0.balances);
        let v1 = 0;
        while (!0x1::vector::is_empty<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::BalanceItem>(&v0)) {
            let (v2, v3) = 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::into_values(0x1::vector::pop_back<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::BalanceItem>(&mut v0));
            let v4 = 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::pull_raw_price(arg2, v2, arg1);
            let v5 = if (0x2::table::contains<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg3, v2)) {
                *0x2::table::borrow<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg3, v2)
            } else {
                0x1::uq32_32::from_int(0)
            };
            v1 = v1 + 0x1::uq32_32::int_mul(0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::calc_quote_out(&v4, v3), v5);
        };
        0x1::vector::destroy_empty<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::balances::BalanceItem>(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

