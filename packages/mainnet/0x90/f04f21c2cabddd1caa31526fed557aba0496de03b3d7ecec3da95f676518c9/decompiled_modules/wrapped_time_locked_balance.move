module 0x26fbf58546decb68861cf58126f982263646628989e8bea2b5219c7982c9949b::wrapped_time_locked_balance {
    struct WrappedTimeLockedBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        inner: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::TimeLockedBalance<T0>,
    }

    public fun borrow<T0>(arg0: &WrappedTimeLockedBalance<T0>) : &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::TimeLockedBalance<T0> {
        &arg0.inner
    }

    public fun change_unlock_start_ts_sec<T0>(arg0: &mut WrappedTimeLockedBalance<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::change_unlock_start_ts_sec<T0>(&mut arg0.inner, arg1, arg2);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : WrappedTimeLockedBalance<T0> {
        WrappedTimeLockedBalance<T0>{
            id    : 0x2::object::new(arg3),
            inner : 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::create<T0>(arg0, arg1, arg2),
        }
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

    public fun top_up_and_reconfigure<T0>(arg0: &mut WrappedTimeLockedBalance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::util::timestamp_sec(arg3);
        assert!(arg2 > v0, 9223372307437715455);
        0x2::balance::join<T0>(&mut arg1, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::withdraw_all<T0>(&mut arg0.inner, arg3));
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.inner, 0, arg3);
        0x2::balance::join<T0>(&mut arg1, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.inner));
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::change_unlock_start_ts_sec<T0>(&mut arg0.inner, v0, arg3);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::top_up<T0>(&mut arg0.inner, arg1, arg3);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.inner, 0x2::balance::value<T0>(&arg1) / (arg2 - v0), arg3);
    }

    public fun withdraw_and_destroy<T0>(arg0: WrappedTimeLockedBalance<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let WrappedTimeLockedBalance {
            id    : v0,
            inner : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        let v3 = 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::withdraw_all<T0>(&mut v2, arg1);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::change_unlock_per_second<T0>(&mut v2, 0, arg1);
        0x2::balance::join<T0>(&mut v3, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::skim_extraneous_balance<T0>(&mut v2));
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::time_locked_balance::destroy_empty<T0>(v2);
        v3
    }

    // decompiled from Move bytecode v6
}

