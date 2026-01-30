module 0x5d78f1de16447392a1da648c61f269bc53560878dc33f5f6365c71dbee2cd1d7::staked_faucet {
    struct LockedStake has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        original_amount: u64,
        lock_expiration: u64,
        owner: address,
    }

    struct StakeEvent has copy, drop {
        sender_address: address,
        amount: u64,
        lock_expiration_timestamp: u64,
        locked_stake_id: 0x2::object::ID,
    }

    struct UnstakeEvent has copy, drop {
        sender_address: address,
        amount: u64,
        locked_stake_id: 0x2::object::ID,
    }

    public fun balance(arg0: &LockedStake) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun lock_duration_ms() : u64 {
        31536000000
    }

    public fun lock_expiration(arg0: &LockedStake) : u64 {
        arg0.lock_expiration
    }

    public fun original_amount(arg0: &LockedStake) : u64 {
        arg0.original_amount
    }

    public fun owner(arg0: &LockedStake) : address {
        arg0.owner
    }

    public fun stake(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : LockedStake {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg1) + 31536000000;
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = LockedStake{
            id              : 0x2::object::new(arg2),
            balance         : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            original_amount : v0,
            lock_expiration : v1,
            owner           : v2,
        };
        let v4 = StakeEvent{
            sender_address            : v2,
            amount                    : v0,
            lock_expiration_timestamp : v1,
            locked_stake_id           : 0x2::object::id<LockedStake>(&v3),
        };
        0x2::event::emit<StakeEvent>(v4);
        v3
    }

    entry fun stake_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0, arg1, arg2);
        0x2::transfer::transfer<LockedStake>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun unstake(arg0: LockedStake, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.lock_expiration, 0);
        let LockedStake {
            id              : v0,
            balance         : v1,
            original_amount : _,
            lock_expiration : _,
            owner           : _,
        } = arg0;
        let v5 = v1;
        let v6 = v0;
        let v7 = UnstakeEvent{
            sender_address  : 0x2::tx_context::sender(arg2),
            amount          : 0x2::balance::value<0x2::sui::SUI>(&v5),
            locked_stake_id : 0x2::object::uid_to_inner(&v6),
        };
        0x2::event::emit<UnstakeEvent>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg2)
    }

    entry fun unstake_and_transfer(arg0: LockedStake, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

