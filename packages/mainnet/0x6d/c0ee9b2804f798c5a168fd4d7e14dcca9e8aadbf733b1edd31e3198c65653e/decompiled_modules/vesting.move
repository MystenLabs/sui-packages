module 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting {
    struct VestingOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct VestingState<phantom T0> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        start_time: u64,
        total_amount: u64,
        initial_unlock: u64,
        release_interval: u64,
        release_rate: u64,
        lock_period: u64,
        vesting_period: u64,
        total_vested: u64,
        reward_balance: 0x2::balance::Balance<T0>,
        unsold_token_withdraw: bool,
    }

    struct Recipient<phantom T0> has key {
        id: 0x2::object::UID,
        vesting_id: 0x2::object::ID,
        amount_vested: u64,
        amount_withdrawn: u64,
    }

    public(friend) fun create_user_recipient<T0>(arg0: &VestingState<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Recipient<T0>{
            id               : 0x2::object::new(arg1),
            vesting_id       : 0x2::object::id<VestingState<T0>>(arg0),
            amount_vested    : 0,
            amount_withdrawn : 0,
        };
        0x2::transfer::transfer<Recipient<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun create_vest<T0>(arg0: &VestingOwnerCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingState<T0>{
            id                    : 0x2::object::new(arg9),
            presale_id            : arg1,
            start_time            : arg2,
            total_amount          : 0x2::coin::value<T0>(&arg8),
            initial_unlock        : arg3,
            release_interval      : arg4,
            release_rate          : arg5,
            lock_period           : arg6,
            vesting_period        : arg7,
            total_vested          : 0,
            reward_balance        : 0x2::balance::zero<T0>(),
            unsold_token_withdraw : false,
        };
        0x2::balance::join<T0>(&mut v0.reward_balance, 0x2::coin::into_balance<T0>(arg8));
        0x2::transfer::share_object<VestingState<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VestingOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun locked<T0>(arg0: &VestingState<T0>, arg1: &Recipient<T0>, arg2: &0x2::clock::Clock) : u64 {
        arg1.amount_vested - vested<T0>(arg0, arg1, arg2)
    }

    public fun presale_id<T0>(arg0: &VestingState<T0>) : 0x2::object::ID {
        arg0.presale_id
    }

    entry fun set_start_time<T0>(arg0: &VestingOwnerCap, arg1: &mut VestingState<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.start_time == 0 || arg1.start_time >= v0, 3);
        assert!(arg2 > v0, 3);
        arg1.start_time = arg2;
    }

    public(friend) fun update_recipient<T0>(arg0: &mut VestingState<T0>, arg1: &mut Recipient<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start_time == 0 || arg0.start_time >= 0x2::clock::timestamp_ms(arg3), 3);
        assert!(0x2::object::id<VestingState<T0>>(arg0) == arg1.vesting_id, 0);
        assert!(arg2 > 0, 1);
        arg0.total_vested = arg0.total_vested + arg2 - arg1.amount_vested;
        assert!(arg0.total_amount >= arg0.total_vested, 2);
        arg1.amount_vested = arg2;
    }

    public fun vested<T0>(arg0: &VestingState<T0>, arg1: &Recipient<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.start_time + arg0.lock_period;
        if (arg0.start_time == 0 || arg1.amount_vested == 0 || v0 <= v1) {
            return 0
        };
        if (v0 > v1 + arg0.vesting_period) {
            return arg1.amount_vested
        };
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math64::min(0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math64::max(arg1.amount_withdrawn, (v0 - v1) / arg0.release_interval * arg1.amount_vested * arg0.release_rate / 1000000 + arg1.amount_vested * arg0.initial_unlock / 1000000), arg1.amount_vested)
    }

    entry fun withdraw<T0>(arg0: &mut VestingState<T0>, arg1: &mut Recipient<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdrawable<T0>(arg0, arg1, arg2);
        arg1.amount_withdrawn = vested<T0>(arg0, arg1, arg2);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public(friend) fun withdraw_unsold<T0>(arg0: &mut VestingState<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.unsold_token_withdraw == false, 4);
        arg0.unsold_token_withdraw = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, arg0.total_amount - arg0.total_vested, arg2), arg1);
    }

    public fun withdrawable<T0>(arg0: &VestingState<T0>, arg1: &Recipient<T0>, arg2: &0x2::clock::Clock) : u64 {
        vested<T0>(arg0, arg1, arg2) - arg1.amount_withdrawn
    }

    // decompiled from Move bytecode v6
}

