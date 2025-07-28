module 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::milestone {
    struct LockedPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        token_balance: 0x2::balance::Balance<T1>,
        usda_balance: 0x2::balance::Balance<T0>,
        milestone_round: u8,
        incentive_type: u8,
        current_milestone_start: bool,
        start_times: u64,
        position_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
    }

    struct VestingConfig has key {
        id: 0x2::object::UID,
        version: u64,
        locked_supply: u64,
        total_supply: u64,
        milestone_count: u8,
        lasting_time: u64,
        milestone_fdvs: vector<u64>,
        milestone_total_unlocked: vector<u64>,
    }

    struct MilestoneUpdatedEvent has copy, drop {
        project_id: 0x2::object::ID,
        count: u64,
        milestone_round: u8,
        current_fdv: u64,
        target_fdv: u64,
        total_unlocked_tokens: u64,
    }

    struct UserClaimedEvent has copy, drop {
        project_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public fun assert_version(arg0: &VestingConfig) {
        assert!(arg0.version == 0, 4);
    }

    public fun check_if_update_milestone<T0, T1>(arg0: &mut LockedPool<T0, T1>, arg1: &VestingConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock) : (bool, bool, bool) {
        assert_version(arg1);
        let v0 = arg0.current_milestone_start == true && 0x2::clock::timestamp_ms(arg5) - arg0.start_times > arg1.lasting_time;
        ((0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::cetus::get_token_price<T0, T1>(arg2, arg3, arg4) as u64) * arg1.total_supply >= get_milestone_target_fdv(arg0.milestone_round, arg1), arg0.current_milestone_start, v0)
    }

    public fun claim<T0, T1>(arg0: &mut LockedPool<T0, T1>, arg1: &mut 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::FundingProof, arg2: &VestingConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        let v0 = claimable<T0, T1>(arg0, arg1, arg2);
        assert!(v0 > 0, 0);
        assert!(0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::get_proof_project_id(arg1) == arg0.project_id, 1);
        0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::update_proof_claimed(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token_balance, v0, arg3), 0x2::tx_context::sender(arg3));
        let v1 = UserClaimedEvent{
            project_id : arg0.project_id,
            user       : 0x2::tx_context::sender(arg3),
            amount     : v0,
        };
        0x2::event::emit<UserClaimedEvent>(v1);
    }

    public(friend) fun claimable<T0, T1>(arg0: &LockedPool<T0, T1>, arg1: &0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::FundingProof, arg2: &VestingConfig) : u64 {
        assert!(0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::get_proof_project_id(arg1) == arg0.project_id, 1);
        let v0 = (0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::get_proof_token(arg1) as u128) * (get_milestone_total_unlocked(arg0.milestone_round, arg2) as u128) / (800000000 as u128);
        let v1 = 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::get_proof_claimed(arg1);
        if ((v0 as u64) > v1) {
            (v0 as u64) - v1
        } else {
            0
        }
    }

    public fun get_current_target_fdv<T0, T1>(arg0: &LockedPool<T0, T1>, arg1: &VestingConfig) : u64 {
        get_milestone_target_fdv(arg0.milestone_round, arg1)
    }

    public fun get_locked_supply(arg0: &VestingConfig) : u64 {
        arg0.locked_supply
    }

    public fun get_milestone_count(arg0: &VestingConfig) : u8 {
        arg0.milestone_count
    }

    public fun get_milestone_round<T0, T1>(arg0: &LockedPool<T0, T1>) : u8 {
        arg0.milestone_round
    }

    public fun get_milestone_target_fdv(arg0: u8, arg1: &VestingConfig) : u64 {
        assert!(arg0 < arg1.milestone_count, 2);
        *0x1::vector::borrow<u64>(&arg1.milestone_fdvs, (arg0 as u64))
    }

    public fun get_milestone_total_unlocked(arg0: u8, arg1: &VestingConfig) : u64 {
        assert!(arg0 < arg1.milestone_count, 2);
        *0x1::vector::borrow<u64>(&arg1.milestone_total_unlocked, (arg0 as u64))
    }

    public fun get_token_balance<T0, T1>(arg0: &LockedPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.token_balance)
    }

    public fun get_total_supply(arg0: &VestingConfig) : u64 {
        arg0.total_supply
    }

    public fun get_total_unlocked_tokens<T0, T1>(arg0: &LockedPool<T0, T1>, arg1: &VestingConfig) : u64 {
        get_milestone_total_unlocked(arg0.milestone_round, arg1)
    }

    public fun get_usda_balance<T0, T1>(arg0: &LockedPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.usda_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingConfig{
            id                       : 0x2::object::new(arg0),
            version                  : 0,
            locked_supply            : 800000000,
            total_supply             : 1000000000,
            milestone_count          : 16,
            lasting_time             : 259200000,
            milestone_fdvs           : vector[5000, 20000, 50000, 100000, 300000, 600000, 1000000, 1500000, 2000000, 3000000, 4000000, 5000000, 7000000, 8000000, 9000000, 10000000],
            milestone_total_unlocked : vector[0, 10000000, 40000000, 80000000, 140000000, 200000000, 260000000, 320000000, 380000000, 440000000, 500000000, 560000000, 620000000, 680000000, 740000000, 800000000],
        };
        0x2::transfer::share_object<VestingConfig>(v0);
    }

    public(friend) fun migrate(arg0: &mut VestingConfig) {
        assert!(arg0.version < 0, 4);
        let v0 = VersionUpdatedEvent{
            old_version : arg0.version,
            new_version : 0,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
        arg0.version = 0;
    }

    public(friend) entry fun new_wallet<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::ProjectManager<T0>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LockedPool<T0, T1>{
            id                      : 0x2::object::new(arg5),
            token_balance           : 0x2::coin::into_balance<T1>(arg0),
            usda_balance            : 0x2::coin::into_balance<T0>(arg1),
            milestone_round         : 0,
            incentive_type          : arg2,
            current_milestone_start : false,
            start_times             : 0,
            position_id             : arg4,
            project_id              : 0x2::object::id<0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::ProjectManager<T0>>(arg3),
        };
        0x2::transfer::share_object<LockedPool<T0, T1>>(v0);
        0x2::object::id<LockedPool<T0, T1>>(&v0)
    }

    public fun update_milestone<T0, T1>(arg0: &0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::launchpad_manager_config::LaunchAdmin, arg1: &mut LockedPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::ProjectManager<T0>, arg4: &0x2::clock::Clock, arg5: &VestingConfig, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>) {
        assert_version(arg5);
        let v0 = (0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::cetus::get_token_price<T0, T1>(arg2, arg6, arg7) as u64) * arg5.total_supply;
        assert!(v0 >= get_milestone_target_fdv(arg1.milestone_round + 1, arg5), 2);
        if (arg1.current_milestone_start == false) {
            arg1.current_milestone_start = true;
            arg1.start_times = 0x2::clock::timestamp_ms(arg4);
        } else {
            assert!(0x2::clock::timestamp_ms(arg4) - arg1.start_times >= arg5.lasting_time, 3);
            arg1.milestone_round = arg1.milestone_round + 1;
            arg1.current_milestone_start = false;
            let v1 = MilestoneUpdatedEvent{
                project_id            : arg1.project_id,
                count                 : 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::get_project_count<T0>(arg3),
                milestone_round       : arg1.milestone_round,
                current_fdv           : v0,
                target_fdv            : get_milestone_target_fdv(arg1.milestone_round, arg5),
                total_unlocked_tokens : get_milestone_total_unlocked(arg1.milestone_round, arg5),
            };
            0x2::event::emit<MilestoneUpdatedEvent>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

