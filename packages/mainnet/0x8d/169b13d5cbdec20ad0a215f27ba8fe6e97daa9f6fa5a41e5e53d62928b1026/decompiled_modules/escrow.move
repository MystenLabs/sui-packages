module 0x8d169b13d5cbdec20ad0a215f27ba8fe6e97daa9f6fa5a41e5e53d62928b1026::escrow {
    struct Bounty has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        beneficiary: address,
        creator: address,
        escrowed: 0x2::balance::Balance<0x2::sui::SUI>,
        executor_reward: u64,
        available_at: u64,
        years: u8,
        executed: bool,
        locked: bool,
        created_at: u64,
    }

    struct ExecutionReceipt has store, key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
        executor: address,
        reward_paid: u64,
        executed_at: u64,
    }

    public fun available_at(arg0: &Bounty) : u64 {
        arg0.available_at
    }

    public fun beneficiary(arg0: &Bounty) : address {
        arg0.beneficiary
    }

    public entry fun cancel_bounty(arg0: Bounty, arg1: &mut 0x2::tx_context::TxContext) {
        let Bounty {
            id              : v0,
            name            : _,
            beneficiary     : _,
            creator         : v3,
            escrowed        : v4,
            executor_reward : _,
            available_at    : _,
            years           : _,
            executed        : v8,
            locked          : v9,
            created_at      : _,
        } = arg0;
        assert!(v3 == 0x2::tx_context::sender(arg1), 3);
        assert!(!v8, 2);
        assert!(!v9, 6);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1), v3);
    }

    public entry fun create_and_share_bounty(arg0: 0x1::string::String, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Bounty>(create_bounty(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun create_bounty(arg0: 0x1::string::String, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Bounty {
        assert!(arg3 >= 1000000000, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 0);
        assert!(arg5 >= 1 && arg5 <= 5, 5);
        Bounty{
            id              : 0x2::object::new(arg7),
            name            : arg0,
            beneficiary     : arg1,
            creator         : 0x2::tx_context::sender(arg7),
            escrowed        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            executor_reward : arg3,
            available_at    : arg4,
            years           : arg5,
            executed        : false,
            locked          : false,
            created_at      : 0x2::clock::timestamp_ms(arg6),
        }
    }

    public fun creator(arg0: &Bounty) : address {
        arg0.creator
    }

    public fun escrowed_amount(arg0: &Bounty) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrowed)
    }

    public fun execute_bounty(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, address) {
        let (v0, v1) = release_for_registration(arg0, arg1, arg2);
        (v0, v1, arg0.beneficiary)
    }

    public entry fun execute_bounty_entry(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = release_for_registration(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = ExecutionReceipt{
            id          : 0x2::object::new(arg2),
            bounty_id   : 0x2::object::id<Bounty>(arg0),
            executor    : 0x2::tx_context::sender(arg2),
            reward_paid : 0x2::coin::value<0x2::sui::SUI>(&v2),
            executed_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<ExecutionReceipt>(v3, 0x2::tx_context::sender(arg2));
    }

    public fun executor_reward(arg0: &Bounty) : u64 {
        arg0.executor_reward
    }

    public fun is_executed(arg0: &Bounty) : bool {
        arg0.executed
    }

    public fun is_expired(arg0: &Bounty, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.available_at + 604800000
    }

    public fun is_locked(arg0: &Bounty) : bool {
        arg0.locked
    }

    public fun is_ready(arg0: &Bounty, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (!arg0.executed) {
            if (v0 >= arg0.available_at) {
                v0 <= arg0.available_at + 604800000
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun lock_bounty(arg0: &mut Bounty, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 3);
        assert!(!arg0.executed, 2);
        arg0.locked = true;
    }

    public fun name(arg0: &Bounty) : &0x1::string::String {
        &arg0.name
    }

    public entry fun reclaim_expired(arg0: Bounty, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Bounty {
            id              : v0,
            name            : _,
            beneficiary     : _,
            creator         : v3,
            escrowed        : v4,
            executor_reward : _,
            available_at    : v6,
            years           : _,
            executed        : v8,
            locked          : _,
            created_at      : _,
        } = arg0;
        assert!(!v8, 2);
        assert!(0x2::clock::timestamp_ms(arg1) > v6 + 604800000, 1);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2), v3);
    }

    public fun release_for_registration(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.executed, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.available_at, 1);
        assert!(v0 <= arg0.available_at + 604800000, 4);
        arg0.executed = true;
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrowed);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrowed), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrowed, arg0.executor_reward), arg2))
    }

    public fun years(arg0: &Bounty) : u8 {
        arg0.years
    }

    // decompiled from Move bytecode v6
}

