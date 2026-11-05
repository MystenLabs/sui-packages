module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::vesting {
    struct Vesting<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        principal: u64,
        released: u64,
        start_ms: u64,
        cliff_ms: u64,
        end_ms: u64,
        funds: 0x2::balance::Balance<T0>,
    }

    struct Created has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        beneficiary: address,
        amount: u64,
        start_ms: u64,
        cliff_ms: u64,
        end_ms: u64,
    }

    struct Released has copy, drop {
        id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
    }

    public fun beneficiary<T0>(arg0: &Vesting<T0>) : address {
        arg0.beneficiary
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (arg1 != @0x0) {
            if (v0 > 0) {
                if (arg2 < arg4) {
                    if (arg3 >= arg2) {
                        arg3 <= arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = Vesting<T0>{
            id          : 0x2::object::new(arg5),
            beneficiary : arg1,
            principal   : v0,
            released    : 0,
            start_ms    : arg2,
            cliff_ms    : arg3,
            end_ms      : arg4,
            funds       : 0x2::coin::into_balance<T0>(arg0),
        };
        let v3 = 0x2::object::id<Vesting<T0>>(&v2);
        let v4 = Created{
            id          : v3,
            creator     : 0x2::tx_context::sender(arg5),
            beneficiary : arg1,
            amount      : v0,
            start_ms    : arg2,
            cliff_ms    : arg3,
            end_ms      : arg4,
        };
        0x2::event::emit<Created>(v4);
        0x2::transfer::share_object<Vesting<T0>>(v2);
        v3
    }

    public fun release<T0>(arg0: &mut Vesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = vested<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.released;
        assert!(v0 > 0, 2);
        arg0.released = arg0.released + v0;
        let v1 = Released{
            id          : 0x2::object::id<Vesting<T0>>(arg0),
            beneficiary : arg0.beneficiary,
            amount      : v0,
        };
        0x2::event::emit<Released>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v0), arg2), arg0.beneficiary);
    }

    public fun release_surplus<T0>(arg0: &mut Vesting<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.funds) - arg0.principal - arg0.released;
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v0), arg1), arg0.beneficiary);
    }

    public fun released<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.released
    }

    public fun top_up<T0>(arg0: &mut Vesting<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun vested<T0>(arg0: &Vesting<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.cliff_ms || arg1 <= arg0.start_ms) {
            0
        } else if (arg1 >= arg0.end_ms) {
            arg0.principal
        } else {
            (((arg0.principal as u128) * ((arg1 - arg0.start_ms) as u128) / ((arg0.end_ms - arg0.start_ms) as u128)) as u64)
        }
    }

    // decompiled from Move bytecode v7
}

