module 0xa1f2c11169f32165ad4efb4468ec5bdfc880cd66b22094024b32ab7b76d14d30::vesting {
    struct VestingSchedule<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_amount: u64,
        last_claim: u64,
        duration: u64,
        remaining_bal: 0x2::balance::Balance<T0>,
    }

    public(friend) fun claim_vested<T0>(arg0: &mut VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg0.last_claim, 0);
        let v1 = 0x2::balance::value<T0>(&arg0.remaining_bal);
        assert!(v1 > 0, 0);
        let v2 = (((arg0.total_amount as u128) * ((v0 - arg0.last_claim) as u128) / (arg0.duration as u128)) as u64);
        arg0.last_claim = v0;
        if (v2 <= v1) {
            0x2::coin::take<T0>(&mut arg0.remaining_bal, v2, arg2)
        } else {
            0x2::coin::take<T0>(&mut arg0.remaining_bal, v1, arg2)
        }
    }

    public(friend) fun vest_tokens<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : VestingSchedule<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        VestingSchedule<T0>{
            id            : 0x2::object::new(arg3),
            total_amount  : v0,
            last_claim    : arg1,
            duration      : arg2,
            remaining_bal : 0x2::coin::into_balance<T0>(arg0),
        }
    }

    // decompiled from Move bytecode v6
}

