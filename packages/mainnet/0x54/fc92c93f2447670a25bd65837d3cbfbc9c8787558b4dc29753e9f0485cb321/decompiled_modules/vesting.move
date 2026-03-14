module 0x54fc92c93f2447670a25bd65837d3cbfbc9c8787558b4dc29753e9f0485cb321::vesting {
    struct VestingVault<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        start_time_ms: u64,
        total_locked: u64,
        tranches_claimed: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun beneficiary<T0>(arg0: &VestingVault<T0>) : address {
        arg0.beneficiary
    }

    public entry fun claim<T0>(arg0: &mut VestingVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.beneficiary, 0);
        let v1 = 0x2::clock::timestamp_ms(arg1) - arg0.start_time_ms;
        let v2 = 6 * 2592000000;
        assert!(v1 >= v2, 1);
        let v3 = (v1 - v2) / 2592000000;
        let v4 = v3;
        if (v3 > 18) {
            v4 = 18;
        };
        let v5 = v4 - arg0.tranches_claimed;
        assert!(v5 > 0, 2);
        let v6 = if (arg0.tranches_claimed + v5 == 18) {
            0x2::balance::value<T0>(&arg0.balance)
        } else {
            v5 * arg0.total_locked / 18
        };
        arg0.tranches_claimed = arg0.tranches_claimed + v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v6), arg2), v0);
    }

    public entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingVault<T0>{
            id               : 0x2::object::new(arg2),
            beneficiary      : 0x2::tx_context::sender(arg2),
            start_time_ms    : 0x2::clock::timestamp_ms(arg1),
            total_locked     : 0x2::coin::value<T0>(&arg0),
            tranches_claimed : 0,
            balance          : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<VestingVault<T0>>(v0);
    }

    public fun remaining_balance<T0>(arg0: &VestingVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun start_time_ms<T0>(arg0: &VestingVault<T0>) : u64 {
        arg0.start_time_ms
    }

    public fun total_locked<T0>(arg0: &VestingVault<T0>) : u64 {
        arg0.total_locked
    }

    public fun tranches_claimed<T0>(arg0: &VestingVault<T0>) : u64 {
        arg0.tranches_claimed
    }

    // decompiled from Move bytecode v6
}

