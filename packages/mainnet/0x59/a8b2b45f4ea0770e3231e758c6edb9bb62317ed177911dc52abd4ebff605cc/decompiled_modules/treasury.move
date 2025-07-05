module 0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        version: u64,
        funds: 0x2::bag::Bag,
    }

    public fun balance_of<T0>(arg0: &mut Treasury) : u64 {
        check_version(arg0);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.funds, 0x1::type_name::get<T0>()))
    }

    public(friend) fun borrow_from_treasury<T0>(arg0: &mut Treasury) : &mut 0x2::balance::Balance<T0> {
        check_version(arg0);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, 0x1::type_name::get<T0>())
    }

    fun check_version(arg0: &Treasury) {
        0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::version::check_version(arg0.version);
    }

    public(friend) fun create_treasury(arg0: &mut 0x2::tx_context::TxContext) : Treasury {
        Treasury{
            id      : 0x2::object::new(arg0),
            version : 0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::version::current_version(),
            funds   : 0x2::bag::new(arg0),
        }
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        check_version(arg0);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.funds, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun withdraw<T0>(arg0: &0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::admin::AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.funds, 0x1::type_name::get<T0>());
        0x2::balance::value<T0>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_some<T0>(arg0: &0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::admin::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.funds, 0x1::type_name::get<T0>()), arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

