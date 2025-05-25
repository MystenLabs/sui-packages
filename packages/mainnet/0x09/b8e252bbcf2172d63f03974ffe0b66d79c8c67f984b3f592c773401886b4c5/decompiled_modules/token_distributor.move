module 0x9b8e252bbcf2172d63f03974ffe0b66d79c8c67f984b3f592c773401886b4c5::token_distributor {
    struct TOKEN_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct SwapRewardDistributed has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardsDeposited has copy, drop {
        admin: address,
        amount: u64,
        total_balance: u64,
    }

    struct RewardsWithdrawn has copy, drop {
        admin: address,
        amount: u64,
        remaining_balance: u64,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct DistributorStatusChanged has copy, drop {
        admin: address,
        active: bool,
    }

    struct DistributorCreated has copy, drop {
        admin: address,
        distributor_id: address,
    }

    struct Distributor<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        reward_balance: 0x2::balance::Balance<T0>,
        total_distributed: u64,
        total_deposits: u64,
        active: bool,
        created_at: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        distributor_id: address,
    }

    public entry fun batch_distribute_rewards<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg0.active, 2);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 3);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v3 > 0 && v3 <= 1000000000000, 3);
            v2 = v2 + v3;
            v1 = v1 + 1;
        };
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= v2, 0);
        v1 = 0;
        while (v1 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg2, v1);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v4 != @0x0, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, v5), arg4), v4);
            arg0.total_distributed = arg0.total_distributed + v5;
            let v6 = SwapRewardDistributed{
                user      : v4,
                amount    : v5,
                timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
            };
            0x2::event::emit<SwapRewardDistributed>(v6);
            v1 = v1 + 1;
        };
    }

    public entry fun create_distributor<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = Distributor<T0>{
            id                : v1,
            admin             : v0,
            reward_balance    : 0x2::balance::zero<T0>(),
            total_distributed : 0,
            total_deposits    : 0,
            active            : true,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v4 = AdminCap{
            id             : 0x2::object::new(arg0),
            distributor_id : v2,
        };
        0x2::transfer::transfer<AdminCap>(v4, v0);
        0x2::transfer::share_object<Distributor<T0>>(v3);
        let v5 = DistributorCreated{
            admin          : v0,
            distributor_id : v2,
        };
        0x2::event::emit<DistributorCreated>(v5);
    }

    public entry fun deposit_rewards<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg3 > 0, 3);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 6);
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        arg0.total_deposits = arg0.total_deposits + arg3;
        let v0 = RewardsDeposited{
            admin         : 0x2::tx_context::sender(arg4),
            amount        : arg3,
            total_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<RewardsDeposited>(v0);
    }

    public entry fun distribute_custom_reward<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg0.active, 2);
        assert!(arg2 != @0x0, 4);
        assert!(arg3 > 0 && arg3 <= 1000000000000, 3);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg3), arg4), arg2);
        arg0.total_distributed = arg0.total_distributed + arg3;
        let v0 = SwapRewardDistributed{
            user      : arg2,
            amount    : arg3,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<SwapRewardDistributed>(v0);
    }

    public(friend) fun distribute_reward_internal<T0>(arg0: &mut Distributor<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg1 != @0x0, 4);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= 10000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, 10000000000), arg2), arg1);
        arg0.total_distributed = arg0.total_distributed + 10000000000;
        let v0 = SwapRewardDistributed{
            user      : arg1,
            amount    : 10000000000,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SwapRewardDistributed>(v0);
    }

    public entry fun distribute_swap_reward<T0>(arg0: &mut Distributor<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.active, 2);
        assert!(arg1 != @0x0, 4);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= 10000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, 10000000000), arg2), arg1);
        arg0.total_distributed = arg0.total_distributed + 10000000000;
        let v0 = SwapRewardDistributed{
            user      : arg1,
            amount    : 10000000000,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SwapRewardDistributed>(v0);
    }

    public entry fun emergency_pause<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        arg0.active = false;
        let v0 = DistributorStatusChanged{
            admin  : arg0.admin,
            active : false,
        };
        0x2::event::emit<DistributorStatusChanged>(v0);
    }

    public entry fun emergency_withdraw_all<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.reward_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.reward_balance), arg2), arg0.admin);
            let v1 = RewardsWithdrawn{
                admin             : arg0.admin,
                amount            : v0,
                remaining_balance : 0,
            };
            0x2::event::emit<RewardsWithdrawn>(v1);
        };
    }

    public fun get_admin<T0>(arg0: &Distributor<T0>) : address {
        arg0.admin
    }

    public fun get_created_at<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.created_at
    }

    public fun get_distributor_stats<T0>(arg0: &Distributor<T0>) : (u64, u64, u64, bool) {
        (0x2::balance::value<T0>(&arg0.reward_balance), arg0.total_distributed, arg0.total_deposits, arg0.active)
    }

    public fun get_max_reward_amount() : u64 {
        1000000000000
    }

    public fun get_reward_amount() : u64 {
        10000000000
    }

    public fun get_reward_balance<T0>(arg0: &Distributor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_balance)
    }

    public fun get_total_deposits<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.total_deposits
    }

    public fun get_total_distributed<T0>(arg0: &Distributor<T0>) : u64 {
        arg0.total_distributed
    }

    fun init(arg0: TOKEN_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TOKEN_DISTRIBUTOR>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_active<T0>(arg0: &Distributor<T0>) : bool {
        arg0.active
    }

    public entry fun set_active<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        arg0.active = arg2;
        let v0 = DistributorStatusChanged{
            admin  : arg0.admin,
            active : arg2,
        };
        0x2::event::emit<DistributorStatusChanged>(v0);
    }

    public entry fun transfer_admin<T0>(arg0: &mut Distributor<T0>, arg1: AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg2 != @0x0, 4);
        assert!(arg2 != arg0.admin, 5);
        arg0.admin = arg2;
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
        let v0 = AdminChanged{
            old_admin : arg0.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun withdraw_rewards<T0>(arg0: &mut Distributor<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.distributor_id, 1);
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg2, 0);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, arg2), arg4));
        let v0 = RewardsWithdrawn{
            admin             : arg0.admin,
            amount            : arg2,
            remaining_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<RewardsWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

