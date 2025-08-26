module 0xbaf9bf71afceda003ff765d18ba4789a4c539726bd6078a69655575027f76ee4::vesting_pool {
    struct VestingPoolCreated has copy, drop {
        pool_id: address,
        deployer: address,
    }

    struct VestingPoolInitialized has copy, drop {
        pool_id: address,
        total_tokens: u64,
    }

    struct VestingPoolActivated has copy, drop {
        pool_id: address,
        activation_time: u64,
    }

    struct TokensClaimed has copy, drop {
        pool_id: address,
        amount: u64,
        months_claimed: u64,
        timestamp: u64,
    }

    struct TeamVestingPool<phantom T0> has key {
        id: 0x2::object::UID,
        deployer: address,
        token_balance: 0x2::balance::Balance<T0>,
        is_initialized: bool,
        is_activated: bool,
        activation_time: u64,
        total_withdrawn: u64,
        last_claimed_month: u64,
    }

    entry fun activate<T0>(arg0: &mut TeamVestingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        activate_vesting<T0>(arg0, arg1, arg2);
    }

    public fun activate_vesting<T0>(arg0: &mut TeamVestingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 1);
        assert!(arg0.is_initialized, 3);
        assert!(!arg0.is_activated, 4);
        arg0.is_activated = true;
        arg0.activation_time = 0x2::clock::timestamp_ms(arg1);
        let v0 = VestingPoolActivated{
            pool_id         : 0x2::object::uid_to_address(&arg0.id),
            activation_time : arg0.activation_time,
        };
        0x2::event::emit<VestingPoolActivated>(v0);
    }

    public fun calculate_claimable_tokens<T0>(arg0: &TeamVestingPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (!arg0.is_activated) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.activation_time + 2592000000;
        if (v0 < v1) {
            return 0
        };
        let v2 = (v0 - v1) / 2592000000;
        let v3 = v2;
        if (v2 > 48) {
            v3 = 48;
        };
        let v4 = if (v3 == 48) {
            150000000000000000
        } else {
            v3 * 3125000000000000
        };
        if (v4 > arg0.total_withdrawn) {
            v4 - arg0.total_withdrawn
        } else {
            0
        }
    }

    entry fun create_and_share_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<TeamVestingPool<T0>>(create_vesting_pool<T0>(arg0));
    }

    public fun create_vesting_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : TeamVestingPool<T0> {
        let v0 = TeamVestingPool<T0>{
            id                 : 0x2::object::new(arg0),
            deployer           : 0x2::tx_context::sender(arg0),
            token_balance      : 0x2::balance::zero<T0>(),
            is_initialized     : false,
            is_activated       : false,
            activation_time    : 0,
            total_withdrawn    : 0,
            last_claimed_month : 0,
        };
        let v1 = VestingPoolCreated{
            pool_id  : 0x2::object::uid_to_address(&v0.id),
            deployer : v0.deployer,
        };
        0x2::event::emit<VestingPoolCreated>(v1);
        v0
    }

    public fun get_pool_info<T0>(arg0: &TeamVestingPool<T0>) : (address, u64, bool, bool, u64, u64, u64) {
        (arg0.deployer, 0x2::balance::value<T0>(&arg0.token_balance), arg0.is_initialized, arg0.is_activated, arg0.activation_time, arg0.total_withdrawn, arg0.last_claimed_month)
    }

    public fun get_vesting_schedule_info() : (u64, u64, u64, u64, u64) {
        (150000000000000000, 2592000000, 48, 3125000000000000, 2592000000)
    }

    public fun initialize_pool<T0>(arg0: &mut TeamVestingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 1);
        assert!(!arg0.is_initialized, 2);
        assert!(0x2::coin::value<T0>(&arg1) == 150000000000000000, 6);
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.is_initialized = true;
        let v0 = VestingPoolInitialized{
            pool_id      : 0x2::object::uid_to_address(&arg0.id),
            total_tokens : 150000000000000000,
        };
        0x2::event::emit<VestingPoolInitialized>(v0);
    }

    entry fun initialize_with_tokens<T0>(arg0: &mut TeamVestingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        initialize_pool<T0>(arg0, arg1, arg2);
    }

    entry fun withdraw<T0>(arg0: &mut TeamVestingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_tokens<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_tokens<T0>(arg0: &mut TeamVestingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 1);
        assert!(arg0.is_activated, 5);
        let v0 = calculate_claimable_tokens<T0>(arg0, arg1);
        assert!(v0 > 0, 7);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = (v1 - arg0.activation_time + 2592000000) / 2592000000;
        let v3 = v2;
        if (v2 > 48) {
            v3 = 48;
        };
        arg0.total_withdrawn = arg0.total_withdrawn + v0;
        arg0.last_claimed_month = v3;
        let v4 = TokensClaimed{
            pool_id        : 0x2::object::uid_to_address(&arg0.id),
            amount         : v0,
            months_claimed : v3 - arg0.last_claimed_month,
            timestamp      : v1,
        };
        0x2::event::emit<TokensClaimed>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

