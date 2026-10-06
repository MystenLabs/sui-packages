module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::tracked_balance {
    struct TrackedBalance<phantom T0> {
        balance: 0x2::balance::Balance<T0>,
        amount: u64,
    }

    public fun is_some<T0>(arg0: &0x1::option::Option<TrackedBalance<T0>>) : bool {
        0x1::option::is_some<TrackedBalance<T0>>(arg0)
    }

    public fun none<T0>() : 0x1::option::Option<TrackedBalance<T0>> {
        0x1::option::none<TrackedBalance<T0>>()
    }

    public fun some<T0>(arg0: 0x2::balance::Balance<T0>) : 0x1::option::Option<TrackedBalance<T0>> {
        0x1::option::some<TrackedBalance<T0>>(wrap<T0>(arg0))
    }

    public fun amount<T0>(arg0: &TrackedBalance<T0>) : u64 {
        arg0.amount
    }

    public fun close<T0>(arg0: 0x1::option::Option<TrackedBalance<T0>>) {
        assert!(0x1::option::is_none<TrackedBalance<T0>>(&arg0), 903);
        0x1::option::destroy_none<TrackedBalance<T0>>(arg0);
    }

    public fun open<T0>(arg0: 0x1::option::Option<TrackedBalance<T0>>) : (0x2::balance::Balance<T0>, u64) {
        assert!(0x1::option::is_some<TrackedBalance<T0>>(&arg0), 902);
        unwrap<T0>(0x1::option::destroy_some<TrackedBalance<T0>>(arg0))
    }

    public fun unwrap<T0>(arg0: TrackedBalance<T0>) : (0x2::balance::Balance<T0>, u64) {
        let TrackedBalance {
            balance : v0,
            amount  : v1,
        } = arg0;
        let v2 = v0;
        assert!(0x2::balance::value<T0>(&v2) == v1, 901);
        (v2, v1)
    }

    public fun wrap<T0>(arg0: 0x2::balance::Balance<T0>) : TrackedBalance<T0> {
        TrackedBalance<T0>{
            balance : arg0,
            amount  : 0x2::balance::value<T0>(&arg0),
        }
    }

    // decompiled from Move bytecode v7
}

