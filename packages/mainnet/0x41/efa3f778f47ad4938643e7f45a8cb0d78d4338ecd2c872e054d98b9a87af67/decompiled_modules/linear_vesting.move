module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::linear_vesting {
    struct VestingWallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        claimed: u64,
        duration: u64,
        claim_cap_id: 0x2::object::ID,
    }

    struct ClaimCap has store, key {
        id: 0x2::object::UID,
    }

    public fun balance<T0>(arg0: &VestingWallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun claim<T0>(arg0: &mut VestingWallet<T0>, arg1: &0x2::clock::Clock, arg2: &ClaimCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<ClaimCap>(arg2) == arg0.claim_cap_id, 13906834466401288195);
        let v0 = claimable<T0>(arg0, arg1);
        arg0.claimed = arg0.claimed + v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg3)
    }

    public fun claimable<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start) {
            return 0
        };
        if (v0 >= arg0.start + arg0.duration) {
            return 0x2::balance::value<T0>(&arg0.balance)
        };
        ((((0x2::balance::value<T0>(&arg0.balance) + arg0.claimed) as u128) * ((v0 - arg0.start) as u128) / (arg0.duration as u128)) as u64) - arg0.claimed
    }

    public fun delete_wallet<T0>(arg0: VestingWallet<T0>, arg1: ClaimCap) {
        assert!(0x2::object::id<ClaimCap>(&arg1) == arg0.claim_cap_id, 13906834509350961155);
        let VestingWallet {
            id           : v0,
            balance      : v1,
            start        : _,
            claimed      : _,
            duration     : _,
            claim_cap_id : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        let ClaimCap { id: v6 } = arg1;
        0x2::object::delete(v6);
    }

    public fun duration<T0>(arg0: &VestingWallet<T0>) : u64 {
        arg0.duration
    }

    public fun new_wallet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (VestingWallet<T0>, ClaimCap) {
        if (arg2 == 0) {
            arg2 = 0x2::clock::timestamp_ms(arg1);
        };
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1), 13906834307487367169);
        let v0 = ClaimCap{id: 0x2::object::new(arg4)};
        let v1 = VestingWallet<T0>{
            id           : 0x2::object::new(arg4),
            balance      : 0x2::coin::into_balance<T0>(arg0),
            start        : arg2,
            claimed      : 0,
            duration     : arg3,
            claim_cap_id : 0x2::object::id<ClaimCap>(&v0),
        };
        (v1, v0)
    }

    public fun start<T0>(arg0: &VestingWallet<T0>) : u64 {
        arg0.start
    }

    // decompiled from Move bytecode v6
}

