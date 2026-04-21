module 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting {
    public fun available_balance(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: &0x1::type_name::TypeName) : u64 {
        let v0 = get_or_zero(arg0, arg2);
        let v1 = get_or_zero(arg1, arg2);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun calculate_deposit_fee(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v1 = if (v0 > arg2) {
            v0
        } else {
            arg2
        };
        let v2 = if (v1 > arg0) {
            arg0
        } else {
            v1
        };
        (arg0 - v2, v2)
    }

    public fun calculate_limit_order_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun calculate_shares_to_mint(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg1 == 0) {
            (arg0, 1000 + arg0)
        } else {
            assert!(arg2 > 0, 0);
            let v2 = (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64);
            (v2, arg1 + v2)
        }
    }

    public fun calculate_shares_to_withdraw(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        assert!(arg1 > 0, 0);
        let v0 = (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64);
        let v1 = (((arg0 as u128) * (arg3 as u128) / (arg1 as u128)) as u64);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        let v3 = (((v2 as u128) * (arg4 as u128) / (10000 as u128)) as u64);
        (v0 - v3, v2, v3)
    }

    public fun calculate_yield_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 <= arg1) {
            0
        } else {
            ((((arg0 - arg1) as u128) * (arg2 as u128) / (10000 as u128)) as u64)
        }
    }

    public fun charge_deposit_fee<T0>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::UserPool, arg1: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::FeePool, arg2: u64) {
        if (arg2 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::fee_join<T0>(arg1, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_split<T0>(arg0, arg2));
        };
    }

    public fun charge_limit_order_fee<T0>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::FeePool, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        if (arg2 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::fee_join<T0>(arg0, 0x2::balance::split<T0>(arg1, arg2));
        };
    }

    public fun charge_yield_fee<T0>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::FeePool, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        if (arg2 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::fee_join<T0>(arg0, 0x2::balance::split<T0>(arg1, arg2));
        };
    }

    public fun credit_deposits(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg0, arg1, arg2);
        };
    }

    public fun debit_deposits(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &arg1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::insufficient_balance());
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &arg1);
        assert!(*v0 >= arg2, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::insufficient_balance());
        *v0 = *v0 - arg2;
    }

    public fun get_deposits(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(arg0, arg1)
        } else {
            0
        }
    }

    fun get_or_zero(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun lock_amount(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = get_or_zero(arg0, &arg1);
        assert!(v0 + arg2 <= arg3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::exceeds_max_lock());
        assert!(v0 + arg2 <= arg4, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::insufficient_unlocked_balance());
        set_or_insert(arg0, arg1, v0 + arg2);
    }

    fun set_or_insert(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(arg0, arg1, arg2);
        };
    }

    public fun unlock_amount(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = get_or_zero(arg0, &arg1);
        let v1 = if (v0 >= arg2) {
            v0 - arg2
        } else {
            0
        };
        set_or_insert(arg0, arg1, v1);
    }

    // decompiled from Move bytecode v7
}

