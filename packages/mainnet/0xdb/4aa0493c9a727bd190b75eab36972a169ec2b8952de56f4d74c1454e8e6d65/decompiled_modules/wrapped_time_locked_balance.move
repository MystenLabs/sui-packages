module 0xdb4aa0493c9a727bd190b75eab36972a169ec2b8952de56f4d74c1454e8e6d65::wrapped_time_locked_balance {
    struct WrappedTimeLockedBalance<phantom T0> has key {
        id: 0x2::object::UID,
        inner: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::TimeLockedBalance<T0>,
    }

    public fun borrow<T0>(arg0: &WrappedTimeLockedBalance<T0>) : &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::TimeLockedBalance<T0> {
        &arg0.inner
    }

    public fun change_unlock_start_ts_sec<T0>(arg0: &mut WrappedTimeLockedBalance<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::change_unlock_start_ts_sec<T0>(&mut arg0.inner, arg1, arg2);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedTimeLockedBalance<T0>{
            id    : 0x2::object::new(arg3),
            inner : 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::create<T0>(arg0, arg1, arg2),
        };
        0x2::transfer::transfer<WrappedTimeLockedBalance<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun top_up<T0>(arg0: &mut WrappedTimeLockedBalance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::top_up<T0>(&mut arg0.inner, arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut WrappedTimeLockedBalance<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::withdraw<T0>(&mut arg0.inner, arg1, arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut WrappedTimeLockedBalance<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::withdraw_all<T0>(&mut arg0.inner, arg1)
    }

    // decompiled from Move bytecode v6
}

