module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::linear_vesting {
    struct Wallet<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        coin: 0x2::coin::Coin<T0>,
        released: u64,
        start: u64,
        duration: u64,
    }

    struct ClawbackCapability has store, key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
    }

    public fun clawback<T0>(arg0: &mut Wallet<T0>, arg1: ClawbackCapability, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let ClawbackCapability {
            id        : v0,
            wallet_id : v1,
        } = arg1;
        assert!(v1 == 0x2::object::id<Wallet<T0>>(arg0), 327680);
        0x2::object::delete(v0);
        let v2 = vested_amount(arg0.start, arg0.duration, 0x2::coin::value<T0>(&arg0.coin), arg0.released, 0x2::tx_context::epoch(arg2)) - arg0.released;
        arg0.released = arg0.released + v2;
        0x2::pay::split_and_transfer<T0>(&mut arg0.coin, v2, arg0.beneficiary, arg2);
        let v3 = &mut arg0.coin;
        0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(v3), 0x2::coin::value<T0>(v3), arg2)
    }

    public entry fun clawback_to<T0>(arg0: &mut Wallet<T0>, arg1: ClawbackCapability, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(clawback<T0>(arg0, arg1, arg3), arg2);
    }

    public fun deposit<T0>(arg0: &mut Wallet<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.coin, arg1);
    }

    public fun destroy_clawback_capability(arg0: ClawbackCapability) {
        let ClawbackCapability {
            id        : v0,
            wallet_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun init_wallet<T0>(arg0: address, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Wallet<T0>{
            id          : 0x2::object::new(arg4),
            beneficiary : arg0,
            coin        : 0x2::coin::zero<T0>(arg4),
            released    : 0,
            start       : arg1,
            duration    : arg2,
        };
        if (0x1::option::is_some<address>(&arg3)) {
            let v1 = ClawbackCapability{
                id        : 0x2::object::new(arg4),
                wallet_id : 0x2::object::id<Wallet<T0>>(&v0),
            };
            0x2::transfer::transfer<ClawbackCapability>(v1, 0x1::option::destroy_some<address>(arg3));
        };
        0x2::transfer::share_object<Wallet<T0>>(v0);
    }

    public fun init_wallet_return_clawback<T0>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ClawbackCapability {
        let v0 = Wallet<T0>{
            id          : 0x2::object::new(arg3),
            beneficiary : arg0,
            coin        : 0x2::coin::zero<T0>(arg3),
            released    : 0,
            start       : arg1,
            duration    : arg2,
        };
        let v1 = ClawbackCapability{
            id        : 0x2::object::new(arg3),
            wallet_id : 0x2::object::id<Wallet<T0>>(&v0),
        };
        0x2::transfer::share_object<Wallet<T0>>(v0);
        v1
    }

    public entry fun release<T0>(arg0: &mut Wallet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vested_amount(arg0.start, arg0.duration, 0x2::coin::value<T0>(&arg0.coin), arg0.released, 0x2::tx_context::epoch(arg1)) - arg0.released;
        arg0.released = arg0.released + v0;
        0x2::pay::split_and_transfer<T0>(&mut arg0.coin, v0, arg0.beneficiary, arg1);
    }

    fun vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        vesting_schedule(arg0, arg1, arg2 + arg3, arg4)
    }

    fun vesting_schedule(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg0) {
            return 0
        };
        if (arg3 > arg0 + arg1) {
            return arg2
        };
        arg2 * (arg3 - arg0) / arg1
    }

    public fun vesting_status<T0>(arg0: &Wallet<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = vested_amount(arg0.start, arg0.duration, 0x2::coin::value<T0>(&arg0.coin), arg0.released, 0x2::tx_context::epoch(arg1));
        (v0, v0 - arg0.released)
    }

    public fun wallet_info<T0>(arg0: &Wallet<T0>) : (address, u64, u64, u64, u64) {
        (arg0.beneficiary, 0x2::coin::value<T0>(&arg0.coin), arg0.released, arg0.start, arg0.duration)
    }

    // decompiled from Move bytecode v6
}

