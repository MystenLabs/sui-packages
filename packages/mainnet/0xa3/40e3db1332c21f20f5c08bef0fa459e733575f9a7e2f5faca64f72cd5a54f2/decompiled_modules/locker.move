module 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::locker {
    struct Locker<phantom T0> has store {
        balance: 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::TimeLockedBalance<T0>,
    }

    public fun destroy_empty<T0>(arg0: Locker<T0>) {
        let Locker { balance: v0 } = arg0;
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::destroy_empty<T0>(v0);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : Locker<T0> {
        Locker<T0>{balance: 0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::create<T0>(arg0, arg1, arg2)}
    }

    public fun extraneous_locked_amount<T0>(arg0: &Locker<T0>) : u64 {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::extraneous_locked_amount<T0>(&arg0.balance)
    }

    public fun final_unlock_ts_sec<T0>(arg0: &Locker<T0>) : u64 {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::final_unlock_ts_sec<T0>(&arg0.balance)
    }

    public fun max_withdrawable<T0>(arg0: &Locker<T0>, arg1: &0x2::clock::Clock) : u64 {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::max_withdrawable<T0>(&arg0.balance, arg1)
    }

    public fun remaining_unlock<T0>(arg0: &Locker<T0>, arg1: &0x2::clock::Clock) : u64 {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::remaining_unlock<T0>(&arg0.balance, arg1)
    }

    public fun skim_extraneous_balance<T0>(arg0: &mut Locker<T0>) : 0x2::balance::Balance<T0> {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.balance)
    }

    public fun top_up<T0>(arg0: &mut Locker<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::top_up<T0>(&mut arg0.balance, arg1, arg2);
    }

    public fun unlock_per_second<T0>(arg0: &Locker<T0>) : u64 {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::unlock_per_second<T0>(&arg0.balance)
    }

    public fun unlock_start_ts_sec<T0>(arg0: &Locker<T0>) : u64 {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::unlock_start_ts_sec<T0>(&arg0.balance)
    }

    public fun withdraw<T0>(arg0: &mut Locker<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::withdraw<T0>(&mut arg0.balance, arg1, arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xa340e3db1332c21f20f5c08bef0fa459e733575f9a7e2f5faca64f72cd5a54f2::time_locked_balance::withdraw_all<T0>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

