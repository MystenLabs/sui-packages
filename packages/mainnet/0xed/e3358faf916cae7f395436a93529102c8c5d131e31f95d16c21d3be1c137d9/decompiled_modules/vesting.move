module 0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::vesting {
    struct Vesting has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        locked: 0x2::balance::Balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>,
        total: u64,
        released: u64,
        start_ms: u64,
        cliff_ms: u64,
        duration_ms: u64,
    }

    struct VestingCreated has copy, drop {
        beneficiary: address,
        total: u64,
        start_ms: u64,
        cliff_ms: u64,
        duration_ms: u64,
    }

    struct Claimed has copy, drop {
        beneficiary: address,
        amount: u64,
    }

    public fun beneficiary(arg0: &Vesting) : address {
        arg0.beneficiary
    }

    public fun claim(arg0: &mut Vesting, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER> {
        let v0 = claimable(arg0, arg1);
        assert!(v0 > 0, 0);
        arg0.released = arg0.released + v0;
        let v1 = Claimed{
            beneficiary : arg0.beneficiary,
            amount      : v0,
        };
        0x2::event::emit<Claimed>(v1);
        0x2::coin::from_balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(0x2::balance::split<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(&mut arg0.locked, v0), arg2)
    }

    public fun claimable(arg0: &Vesting, arg1: &0x2::clock::Clock) : u64 {
        vested(arg0, arg1) - arg0.released
    }

    public fun create(arg0: 0x2::coin::Coin<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Vesting {
        let v0 = 0x2::coin::value<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(&arg0);
        let v1 = VestingCreated{
            beneficiary : arg1,
            total       : v0,
            start_ms    : arg2,
            cliff_ms    : arg3,
            duration_ms : arg4,
        };
        0x2::event::emit<VestingCreated>(v1);
        Vesting{
            id          : 0x2::object::new(arg5),
            beneficiary : arg1,
            locked      : 0x2::coin::into_balance<0xede3358faf916cae7f395436a93529102c8c5d131e31f95d16c21d3be1c137d9::xer::XER>(arg0),
            total       : v0,
            released    : 0,
            start_ms    : arg2,
            cliff_ms    : arg3,
            duration_ms : arg4,
        }
    }

    public fun released(arg0: &Vesting) : u64 {
        arg0.released
    }

    public fun total(arg0: &Vesting) : u64 {
        arg0.total
    }

    public fun vested(arg0: &Vesting, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_ms + arg0.cliff_ms) {
            return 0
        };
        if (v0 >= arg0.start_ms + arg0.duration_ms) {
            return arg0.total
        };
        (((arg0.total as u128) * ((v0 - arg0.start_ms) as u128) / (arg0.duration_ms as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

