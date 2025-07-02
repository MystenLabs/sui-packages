module 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier {
    struct FeeTier has store {
        default_fee_rate: u32,
        balances: 0x2::bag::Bag,
        fee_rates: 0x2::table::Table<0x1::ascii::String, u32>,
    }

    struct SetDefaultFeeRateEvent has copy, drop {
        old_fee_rate: u32,
        new_fee_rate: u32,
    }

    struct SetFeeRateEvent has copy, drop {
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
        old_fee_rate: u32,
        new_fee_rate: u32,
    }

    struct CollectFeeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun balance_of<T0>(arg0: &FeeTier) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public(friend) fun collect_fee<T0>(arg0: &mut FeeTier, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_invalid_coin_type());
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = CollectFeeEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v2,
        };
        0x2::event::emit<CollectFeeEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg1)
    }

    public fun default_fee_rate(arg0: &FeeTier) : u32 {
        arg0.default_fee_rate
    }

    public fun fee_amount<T0, T1>(arg0: &FeeTier, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = fee_rate_key<T0, T1>();
        let v1 = if (0x2::table::contains<0x1::ascii::String, u32>(&arg0.fee_rates, v0)) {
            *0x2::table::borrow<0x1::ascii::String, u32>(&arg0.fee_rates, v0)
        } else {
            arg0.default_fee_rate
        };
        if (v1 == 0) {
            return 0
        };
        let v2 = (arg1 as u128) * (v1 as u128) / (1000000 as u128);
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        (v3 as u64)
    }

    public fun fee_rate<T0, T1>(arg0: &FeeTier) : u32 {
        let v0 = fee_rate_key<T0, T1>();
        if (0x2::table::contains<0x1::ascii::String, u32>(&arg0.fee_rates, v0)) {
            *0x2::table::borrow<0x1::ascii::String, u32>(&arg0.fee_rates, v0)
        } else {
            arg0.default_fee_rate
        }
    }

    public fun fee_rate_key<T0, T1>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x1::ascii::append(&mut v0, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        v0
    }

    public(friend) fun new_fee_tier(arg0: &mut 0x2::tx_context::TxContext) : FeeTier {
        FeeTier{
            default_fee_rate : 1000,
            balances         : 0x2::bag::new(arg0),
            fee_rates        : 0x2::table::new<0x1::ascii::String, u32>(arg0),
        }
    }

    public(friend) fun receive_fee<T0>(arg0: &mut FeeTier, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public(friend) fun set_default_fee_rate(arg0: &mut FeeTier, arg1: u32) {
        assert!(arg1 <= 200000, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_max_fee_rate_limit());
        arg0.default_fee_rate = arg1;
        let v0 = SetDefaultFeeRateEvent{
            old_fee_rate : arg0.default_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<SetDefaultFeeRateEvent>(v0);
    }

    public(friend) fun set_fee_rate<T0, T1>(arg0: &mut FeeTier, arg1: u32) {
        assert!(arg1 <= 200000, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_max_fee_rate_limit());
        let v0 = fee_rate_key<T0, T1>();
        let v1 = if (0x2::table::contains<0x1::ascii::String, u32>(&arg0.fee_rates, v0)) {
            let v2 = 0x2::table::borrow_mut<0x1::ascii::String, u32>(&mut arg0.fee_rates, v0);
            *v2 = arg1;
            *v2
        } else {
            0x2::table::add<0x1::ascii::String, u32>(&mut arg0.fee_rates, v0, arg1);
            arg0.default_fee_rate
        };
        let v3 = fee_rate_key<T1, T0>();
        if (0x2::table::contains<0x1::ascii::String, u32>(&arg0.fee_rates, v3)) {
            *0x2::table::borrow_mut<0x1::ascii::String, u32>(&mut arg0.fee_rates, v3) = arg1;
        } else {
            0x2::table::add<0x1::ascii::String, u32>(&mut arg0.fee_rates, v3, arg1);
        };
        let v4 = SetFeeRateEvent{
            coin_x       : 0x1::type_name::get<T0>(),
            coin_y       : 0x1::type_name::get<T1>(),
            old_fee_rate : v1,
            new_fee_rate : arg1,
        };
        0x2::event::emit<SetFeeRateEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

