module 0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_treasury<T0>(arg0: &0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::admin_cap::AdminCap, arg1: &0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) {
        0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::check_version(arg1);
        0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::check_pause(arg1);
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::Versioned, arg1: &mut Treasury<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::check_version(arg0);
        0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::check_pause(arg0);
        deposit_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun withdraw<T0>(arg0: &0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::admin_cap::AdminCap, arg1: &0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::Versioned, arg2: &mut Treasury<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::check_version(arg1);
        0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::versioned::check_pause(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg2, arg3), arg5), arg4);
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut Treasury<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 <= 0) {
            abort 0
        };
        if (0x2::balance::value<T0>(&arg0.balance) < arg1) {
            abort 1
        };
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

