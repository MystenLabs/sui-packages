module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::linear_unlock_coin {
    struct LinearUnlockCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        unlock_frequency_ms: u64,
        unlock_rate: u64,
        last_unlock_timestamp_ms: u64,
    }

    public fun destroy_zero<T0>(arg0: LinearUnlockCoin<T0>) {
        let LinearUnlockCoin {
            id                       : v0,
            balance                  : v1,
            unlock_frequency_ms      : _,
            unlock_rate              : _,
            last_unlock_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun join<T0>(arg0: &mut LinearUnlockCoin<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun value<T0>(arg0: &LinearUnlockCoin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : LinearUnlockCoin<T0> {
        from_balance<T0>(0x2::balance::zero<T0>(), arg0, arg1, arg2, arg3)
    }

    public fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : LinearUnlockCoin<T0> {
        LinearUnlockCoin<T0>{
            id                       : 0x2::object::new(arg4),
            balance                  : arg0,
            unlock_frequency_ms      : arg1,
            unlock_rate              : arg2,
            last_unlock_timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : LinearUnlockCoin<T0> {
        from_balance<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2, arg3, arg4)
    }

    public fun last_unlock_timestamp_ms<T0>(arg0: &LinearUnlockCoin<T0>) : u64 {
        arg0.last_unlock_timestamp_ms
    }

    public fun set_last_unlock_timestamp_ms<T0>(arg0: &mut LinearUnlockCoin<T0>, arg1: u64) {
        arg0.last_unlock_timestamp_ms = arg1;
    }

    public fun set_unlock_frequency_ms<T0>(arg0: &mut LinearUnlockCoin<T0>, arg1: u64) {
        assert!(arg1 > 0, 13835058746771898369);
        arg0.unlock_frequency_ms = arg1;
    }

    public fun set_unlock_rate<T0>(arg0: &mut LinearUnlockCoin<T0>, arg1: u64) {
        assert!(arg1 > 0, 13835058802606473217);
        arg0.unlock_rate = arg1;
    }

    public fun unlock<T0>(arg0: &mut LinearUnlockCoin<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 < arg0.last_unlock_timestamp_ms + arg0.unlock_frequency_ms || 0x2::balance::value<T0>(&arg0.balance) == 0) {
            0
        } else {
            (v0 - arg0.last_unlock_timestamp_ms) / arg0.unlock_frequency_ms
        };
        if (v1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        arg0.last_unlock_timestamp_ms = arg0.last_unlock_timestamp_ms + v1 * arg0.unlock_frequency_ms;
        0x2::balance::split<T0>(&mut arg0.balance, 0x1::u64::min(0x2::balance::value<T0>(&arg0.balance), v1 * arg0.unlock_rate))
    }

    public fun unlock_frequency_ms<T0>(arg0: &LinearUnlockCoin<T0>) : u64 {
        arg0.unlock_frequency_ms
    }

    public fun unlock_rate<T0>(arg0: &LinearUnlockCoin<T0>) : u64 {
        arg0.unlock_rate
    }

    public fun unlockable_value<T0>(arg0: &LinearUnlockCoin<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 < arg0.last_unlock_timestamp_ms + arg0.unlock_frequency_ms || 0x2::balance::value<T0>(&arg0.balance) == 0) {
            0
        } else {
            (v0 - arg0.last_unlock_timestamp_ms) / arg0.unlock_frequency_ms
        };
        if (v1 == 0) {
            return 0
        };
        0x1::u64::min(0x2::balance::value<T0>(&arg0.balance), v1 * arg0.unlock_rate)
    }

    // decompiled from Move bytecode v6
}

