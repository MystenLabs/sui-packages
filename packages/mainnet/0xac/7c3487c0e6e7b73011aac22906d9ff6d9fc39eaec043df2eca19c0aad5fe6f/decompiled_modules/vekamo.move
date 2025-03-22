module 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::vekamo {
    struct VotingEscrow has key {
        id: 0x2::object::UID,
        locked_balance: 0x2::balance::Balance<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO>,
        end: u64,
        voting_power: u128,
    }

    struct VeKAMOUpdated has copy, drop {
        owner: address,
        locked_amount: u64,
        lock_end: u64,
        voting_power: u128,
    }

    fun calculate_initial_voting_power(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun calculate_voting_power(arg0: &VotingEscrow, arg1: u64) : u128 {
        arg0.voting_power * ((arg0.end - arg1) as u128) / (126144000 as u128)
    }

    public fun create_lock(arg0: 0x2::balance::Balance<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 126144000, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg1;
        let v1 = calculate_initial_voting_power(0x2::balance::value<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO>(&arg0), arg1);
        let v2 = VotingEscrow{
            id             : 0x2::object::new(arg3),
            locked_balance : arg0,
            end            : v0,
            voting_power   : v1,
        };
        let v3 = VeKAMOUpdated{
            owner         : 0x2::tx_context::sender(arg3),
            locked_amount : 0x2::balance::value<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO>(&v2.locked_balance),
            lock_end      : v0,
            voting_power  : v1,
        };
        0x2::event::emit<VeKAMOUpdated>(v3);
        0x2::transfer::transfer<VotingEscrow>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun get_lock_end(arg0: &VotingEscrow) : u64 {
        arg0.end
    }

    public fun get_locked_amount(arg0: &VotingEscrow) : u64 {
        0x2::balance::value<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO>(&arg0.locked_balance)
    }

    public fun get_voting_power(arg0: &VotingEscrow) : u128 {
        arg0.voting_power
    }

    public fun max_lock_time() : u64 {
        126144000
    }

    public fun withdraw(arg0: VotingEscrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO> {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end, 2);
        let VotingEscrow {
            id             : v0,
            locked_balance : v1,
            end            : _,
            voting_power   : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo::KAMO>(v1, arg2)
    }

    // decompiled from Move bytecode v6
}

