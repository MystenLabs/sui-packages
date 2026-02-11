module 0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        receiver: address,
        total_amount: u64,
        claimed_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        lock_start_ms: u64,
        lockup_duration_ms: u64,
        vesting_duration_ms: u64,
    }

    struct TokensClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        total_claimed: u64,
        remaining: u64,
    }

    struct ReceiverTransferred has copy, drop {
        vault_id: 0x2::object::ID,
        old_receiver: address,
        new_receiver: address,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 402);
        Vault<T0>{
            id                  : 0x2::object::new(arg5),
            receiver            : arg1,
            total_amount        : v0,
            claimed_amount      : 0,
            balance             : 0x2::coin::into_balance<T0>(arg0),
            lock_start_ms       : 0x2::clock::timestamp_ms(arg4),
            lockup_duration_ms  : arg2,
            vesting_duration_ms : arg3,
        }
    }

    public fun claim<T0>(arg0: &0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::config::Config, arg1: &mut Vault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::config::assert_not_paused(arg0);
        0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::config::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.receiver, 400);
        let v1 = claimable_amount<T0>(arg1, arg2);
        assert!(v1 > 0, 401);
        arg1.claimed_amount = arg1.claimed_amount + v1;
        let v2 = TokensClaimed{
            vault_id      : 0x2::object::id<Vault<T0>>(arg1),
            claimer       : v0,
            amount        : v1,
            total_claimed : arg1.claimed_amount,
            remaining     : 0x2::balance::value<T0>(&arg1.balance),
        };
        0x2::event::emit<TokensClaimed>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg3)
    }

    public fun claimable_amount<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = vested_amount<T0>(arg0, arg1);
        if (v0 > arg0.claimed_amount) {
            v0 - arg0.claimed_amount
        } else {
            0
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        arg0.total_amount = arg0.total_amount + 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun is_fully_vested<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= vesting_end_ms<T0>(arg0)
    }

    public fun is_lockup_ended<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= lockup_end_ms<T0>(arg0)
    }

    public fun lockup_end_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.lock_start_ms + arg0.lockup_duration_ms
    }

    public fun transfer_receiver<T0>(arg0: &0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::config::Config, arg1: &mut Vault<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::config::assert_not_paused(arg0);
        0xebcdf795145463f8b3fe9498e66d6cb6b239fb0a1d1ffd357ce7352dab8e8084::config::assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.receiver, 400);
        arg1.receiver = arg2;
        let v0 = ReceiverTransferred{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            old_receiver : arg1.receiver,
            new_receiver : arg2,
        };
        0x2::event::emit<ReceiverTransferred>(v0);
    }

    public fun vested_amount<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.lock_start_ms + arg0.lockup_duration_ms;
        if (v0 < v1) {
            return 0
        };
        if (arg0.vesting_duration_ms == 0) {
            return arg0.total_amount
        };
        if (v0 >= v1 + arg0.vesting_duration_ms) {
            return arg0.total_amount
        };
        (((arg0.total_amount as u128) * ((v0 - v1) as u128) / (arg0.vesting_duration_ms as u128)) as u64)
    }

    public fun vesting_end_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.lock_start_ms + arg0.lockup_duration_ms + arg0.vesting_duration_ms
    }

    public fun vesting_progress_bps<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.total_amount == 0) {
            return 10000
        };
        (((vested_amount<T0>(arg0, arg1) as u128) * 10000 / (arg0.total_amount as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

