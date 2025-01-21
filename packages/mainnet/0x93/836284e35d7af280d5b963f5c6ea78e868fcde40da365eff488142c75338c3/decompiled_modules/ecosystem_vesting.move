module 0x93836284e35d7af280d5b963f5c6ea78e868fcde40da365eff488142c75338c3::ecosystem_vesting {
    struct CreateVestingEvent has copy, drop {
        id: 0x2::object::ID,
        total_balance: u64,
        beneficiary: address,
        start_time: u64,
        tge_percent: u64,
        total_rounds: u64,
        days_per_round: u64,
    }

    struct ClaimEvent has copy, drop {
        vesting_id: 0x2::object::ID,
        sender: address,
        release_amount: u64,
    }

    struct CloseEvent has copy, drop {
        vesting_id: 0x2::object::ID,
        sender: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DaoxVestingPool<phantom T0> has key {
        id: 0x2::object::UID,
        token_balance: 0x2::balance::Balance<T0>,
    }

    struct DaoxVesting<phantom T0> has key {
        id: 0x2::object::UID,
        total_balance: u64,
        token_balance: 0x2::balance::Balance<T0>,
        beneficiary: address,
        start_time: u64,
        tge_percent: u64,
        total_rounds: u64,
        days_per_round: u64,
        claimed: u64,
        is_active: bool,
    }

    public fun claim<T0>(arg0: &mut DaoxVesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(arg0.is_active, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_time, 2);
        let v1 = get_claimable<T0>(arg0, v0);
        assert!(v1 > 0, 3);
        arg0.claimed = arg0.claimed + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v1), arg2), arg0.beneficiary);
        let v2 = ClaimEvent{
            vesting_id     : 0x2::object::uid_to_inner(&arg0.id),
            sender         : 0x2::tx_context::sender(arg2),
            release_amount : v1,
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public fun close<T0>(arg0: &AdminCap, arg1: &mut DaoxVesting<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active && arg1.claimed < arg1.total_balance, 4);
        arg1.is_active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_balance, arg1.total_balance - arg1.claimed), arg2), 0x2::tx_context::sender(arg2));
        let v0 = CloseEvent{
            vesting_id : 0x2::object::uid_to_inner(&arg1.id),
            sender     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CloseEvent>(v0);
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DaoxVestingPool<T0>{
            id            : 0x2::object::new(arg2),
            token_balance : 0x2::balance::zero<T0>(),
        };
        0x2::balance::join<T0>(&mut v0.token_balance, arg1);
        0x2::transfer::transfer<DaoxVestingPool<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun create_vesting<T0>(arg0: &AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = DaoxVesting<T0>{
            id             : 0x2::object::new(arg7),
            total_balance  : 0x2::balance::value<T0>(&arg1),
            token_balance  : 0x2::balance::zero<T0>(),
            beneficiary    : arg2,
            start_time     : arg3,
            tge_percent    : arg4,
            total_rounds   : arg5,
            days_per_round : arg6,
            claimed        : 0,
            is_active      : true,
        };
        0x2::balance::join<T0>(&mut v0.token_balance, arg1);
        let v1 = CreateVestingEvent{
            id             : 0x2::object::uid_to_inner(&v0.id),
            total_balance  : v0.total_balance,
            beneficiary    : arg2,
            start_time     : arg3,
            tge_percent    : arg4,
            total_rounds   : arg5,
            days_per_round : arg6,
        };
        0x2::event::emit<CreateVestingEvent>(v1);
        0x2::transfer::share_object<DaoxVesting<T0>>(v0);
    }

    public fun deposit_token<T0>(arg0: &mut DaoxVestingPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.token_balance, arg1);
    }

    fun get_claimable<T0>(arg0: &DaoxVesting<T0>, arg1: u64) : u64 {
        let v0 = 0;
        if (arg0.tge_percent > 0) {
            v0 = arg0.total_balance * arg0.tge_percent / 100;
        };
        let v1 = (arg1 - arg0.start_time) / arg0.days_per_round;
        let v2 = arg0.total_balance - v0;
        if (v1 < arg0.total_rounds) {
            v2 = (arg0.total_balance - v0) * v1 / arg0.total_rounds;
        };
        let v3 = v0 + v2;
        let v4 = 0;
        if (v3 > arg0.claimed) {
            v4 = v3 - arg0.claimed;
        };
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw_token<T0>(arg0: &mut DaoxVestingPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

