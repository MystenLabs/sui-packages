module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury {
    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        fee_configs: 0x2::table::Table<0x1::ascii::String, u64>,
        balances: 0x2::bag::Bag,
    }

    fun borrow_mut_balance<T0>(arg0: &mut Treasury) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    public fun calculate<T0: store + key>(arg0: &Treasury, arg1: u64) : u64 {
        compute(fee_bips<T0>(arg0), arg1)
    }

    public(friend) fun collect<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(borrow_mut_balance<T0>(arg0), arg1);
    }

    public fun compute(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::math::div_round(arg0, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::bps());
        let (_, v3) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::math::mul_round(arg1, v1);
        v3
    }

    public fun fee_bips<T0: store + key>(arg0: &Treasury) : u64 {
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.fee_configs, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
            *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.fee_configs, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
        } else if (0x2::table::contains<0x1::ascii::String, u64>(&arg0.fee_configs, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key())) {
            *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.fee_configs, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key())
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            fee_configs : 0x2::table::new<0x1::ascii::String, u64>(arg0),
            balances    : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun set_collection_config<T0: store + key>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64) {
        set_config(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    fun set_config(arg0: &mut Treasury, arg1: 0x1::ascii::String, arg2: u64) {
        if (!0x2::table::contains<0x1::ascii::String, u64>(&arg0.fee_configs, arg1)) {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.fee_configs, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.fee_configs, arg1) = arg2;
        };
    }

    public entry fun set_default_config(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64) {
        set_config(arg1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key(), arg2);
    }

    public entry fun withdraw<T0>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_<T0>(arg1, arg2, arg4), arg3);
    }

    fun withdraw_<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_mut_balance<T0>(arg0);
        if (0x2::balance::value<T0>(v0) < arg1) {
            abort 0
        };
        0x2::coin::take<T0>(v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

