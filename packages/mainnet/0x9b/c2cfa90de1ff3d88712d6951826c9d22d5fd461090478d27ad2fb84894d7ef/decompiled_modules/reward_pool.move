module 0x9bc2cfa90de1ff3d88712d6951826c9d22d5fd461090478d27ad2fb84894d7ef::reward_pool {
    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        claims: 0x2::table::Table<address, u64>,
        admins: vector<address>,
        total_allocated: u64,
        total_claimed: u64,
    }

    struct RewardAllocated has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct RewardClaimed has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct PoolDeposit has copy, drop {
        amount: u64,
    }

    public entry fun add_admin<T0>(arg0: &mut RewardPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, 0x2::tx_context::sender(arg2)), 0);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
    }

    public entry fun allocate_reward<T0>(arg0: &mut RewardPool<T0>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(arg2 > 0, 3);
        let v0 = if (arg0.total_allocated >= arg0.total_claimed) {
            let v1 = arg0.total_allocated - arg0.total_claimed;
            if (0x2::balance::value<T0>(&arg0.balance) >= v1) {
                0x2::balance::value<T0>(&arg0.balance) - v1
            } else {
                0
            }
        } else {
            0x2::balance::value<T0>(&arg0.balance)
        };
        assert!(v0 >= arg2, 1);
        if (0x2::table::contains<address, u64>(&arg0.claims, arg1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.claims, arg1);
            let v3 = *v2 + arg2;
            assert!(v3 >= *v2, 3);
            *v2 = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claims, arg1, arg2);
        };
        let v4 = arg0.total_allocated + arg2;
        assert!(v4 >= arg0.total_allocated, 3);
        arg0.total_allocated = v4;
        let v5 = RewardAllocated{
            recipient : arg1,
            amount    : arg2,
        };
        0x2::event::emit<RewardAllocated>(v5);
    }

    public entry fun claim_reward<T0>(arg0: &mut RewardPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.claims, v0), 2);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.claims, v0);
        assert!(v1 > 0, 2);
        let v2 = arg0.total_claimed + v1;
        assert!(v2 >= arg0.total_claimed, 3);
        arg0.total_claimed = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg1), v0);
        let v3 = RewardClaimed{
            recipient : v0,
            amount    : v1,
        };
        0x2::event::emit<RewardClaimed>(v3);
    }

    public entry fun create_and_share_pool<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        0x1::vector::push_back<address>(&mut v0, arg1);
        0x2::transfer::share_object<RewardPool<T0>>(create_pool<T0>(v0, arg2));
    }

    public fun create_pool<T0>(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : RewardPool<T0> {
        assert!(0x1::vector::length<address>(&arg0) > 0, 0);
        RewardPool<T0>{
            id              : 0x2::object::new(arg1),
            balance         : 0x2::balance::zero<T0>(),
            claims          : 0x2::table::new<address, u64>(arg1),
            admins          : arg0,
            total_allocated : 0,
            total_claimed   : 0,
        }
    }

    public entry fun deposit_to_pool<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, 0x2::tx_context::sender(arg2)), 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = PoolDeposit{amount: 0x2::coin::value<T0>(&arg1)};
        0x2::event::emit<PoolDeposit>(v0);
    }

    public fun get_claimable_amount<T0>(arg0: &RewardPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claims, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claims, arg1)
        } else {
            0
        }
    }

    public fun get_pool_stats<T0>(arg0: &RewardPool<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_allocated, arg0.total_claimed)
    }

    fun is_admin<T0>(arg0: &RewardPool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun remove_admin<T0>(arg0: &mut RewardPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        };
    }

    // decompiled from Move bytecode v6
}

