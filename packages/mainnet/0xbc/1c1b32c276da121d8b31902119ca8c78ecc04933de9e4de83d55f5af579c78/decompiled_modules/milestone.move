module 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::milestone {
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
        level: u8,
    }

    struct VestingConfig has key {
        id: 0x2::object::UID,
        version: u64,
        configs: 0x2::table::Table<u8, ProjectMilestoneConfig>,
    }

    struct ProjectMilestoneConfig has drop, store {
        level: u8,
        locked_supply: u64,
        total_supply: u64,
        milestone_count: u8,
        lasting_time: u64,
        milestone_prices: vector<u64>,
        milestone_total_unlocked: vector<u64>,
    }

    struct MilestoneUpdatedEvent has copy, drop {
        project_id: 0x2::object::ID,
        count: u64,
        milestone_round: u8,
        current_price: u64,
        target_price: u64,
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

    public fun check_if_update_milestone<T0, T1>(arg0: &mut LockedPool<T0, T1>, arg1: &VestingConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (bool, bool, bool) {
        let v0 = 0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg1.configs, arg0.level);
        assert_version(arg1);
        let v1 = arg0.current_milestone_start == true && 0x2::clock::timestamp_ms(arg3) - arg0.start_times > v0.lasting_time;
        ((0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::cetus::get_sui_token_price<T0, T1>(arg2) as u64) >= get_milestone_target_price(arg0.milestone_round, arg0.level, arg1), arg0.current_milestone_start, v1)
    }

    public fun claim<T0, T1>(arg0: &mut LockedPool<T0, T1>, arg1: &mut 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::FundingProof, arg2: &VestingConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        let v0 = claimable<T0, T1>(arg0, arg1, arg2);
        assert!(v0 > 0, 0);
        assert!(0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::get_proof_project_id(arg1) == arg0.project_id, 1);
        0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::update_proof_claimed(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token_balance, v0, arg3), 0x2::tx_context::sender(arg3));
        let v1 = UserClaimedEvent{
            project_id : arg0.project_id,
            user       : 0x2::tx_context::sender(arg3),
            amount     : v0,
        };
        0x2::event::emit<UserClaimedEvent>(v1);
    }

    public(friend) fun claimable<T0, T1>(arg0: &LockedPool<T0, T1>, arg1: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::FundingProof, arg2: &VestingConfig) : u64 {
        let v0 = 0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg2.configs, arg0.level);
        assert!(0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::get_proof_project_id(arg1) == arg0.project_id, 1);
        let v1 = (0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::get_proof_token(arg1) as u128) * (get_milestone_target_unlocked(arg0.milestone_round, arg0.level, arg2) as u128) / (v0.locked_supply as u128);
        let v2 = 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::get_proof_claimed(arg1);
        if ((v1 as u64) > v2) {
            (v1 as u64) - v2
        } else {
            0
        }
    }

    public fun get_locked_supply(arg0: &VestingConfig) : u64 {
        0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg0.configs, 1).locked_supply
    }

    public fun get_milestone_prices(arg0: u8, arg1: &VestingConfig) : vector<u64> {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 11);
        0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg1.configs, arg0).milestone_prices
    }

    public fun get_milestone_round<T0, T1>(arg0: &LockedPool<T0, T1>) : u8 {
        arg0.milestone_round
    }

    public fun get_milestone_target_price(arg0: u8, arg1: u8, arg2: &VestingConfig) : u64 {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 11);
        let v1 = 0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg2.configs, arg1);
        assert!(arg0 < v1.milestone_count, 2);
        *0x1::vector::borrow<u64>(&v1.milestone_prices, (arg0 as u64))
    }

    public fun get_milestone_target_unlocked(arg0: u8, arg1: u8, arg2: &VestingConfig) : u64 {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 11);
        let v1 = 0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg2.configs, arg1);
        assert!(arg0 < v1.milestone_count, 2);
        *0x1::vector::borrow<u64>(&v1.milestone_total_unlocked, (arg0 as u64))
    }

    public fun get_milestone_total_unlocked(arg0: u8, arg1: &VestingConfig) : vector<u64> {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 11);
        0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg1.configs, arg0).milestone_total_unlocked
    }

    public fun get_rounds(arg0: u8, arg1: &VestingConfig) : u8 {
        0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg1.configs, arg0).milestone_count
    }

    public fun get_token_balance<T0, T1>(arg0: &LockedPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.token_balance)
    }

    public fun get_total_supply(arg0: &VestingConfig) : u64 {
        0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg0.configs, 1).total_supply
    }

    public fun get_total_unlocked_tokens<T0, T1>(arg0: &LockedPool<T0, T1>, arg1: &VestingConfig) : u64 {
        get_milestone_target_unlocked(arg0.milestone_round, arg0.level, arg1)
    }

    public fun get_usda_balance<T0, T1>(arg0: &LockedPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.usda_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, ProjectMilestoneConfig>(arg0);
        let v1 = ProjectMilestoneConfig{
            level                    : 0,
            locked_supply            : 9000000000,
            total_supply             : 10000000000,
            milestone_count          : 20,
            lasting_time             : 86400000,
            milestone_prices         : vector[0, 6, 12, 48, 86, 140, 170, 200, 230, 260, 290, 570, 860, 1150, 1400, 1700, 2000, 2300, 2600, 2900],
            milestone_total_unlocked : vector[0, 200000000, 400000000, 600000000, 800000000, 1000000000, 1300000000, 1600000000, 1900000000, 2300000000, 2700000000, 3200000000, 3700000000, 4300000000, 4900000000, 5600000000, 6300000000, 7100000000, 8000000000, 9000000000],
        };
        0x2::table::add<u8, ProjectMilestoneConfig>(&mut v0, 0, v1);
        let v2 = ProjectMilestoneConfig{
            level                    : 1,
            locked_supply            : 9000000000,
            total_supply             : 10000000000,
            milestone_count          : 20,
            lasting_time             : 86400000,
            milestone_prices         : vector[0, 6, 12, 48, 86, 140, 170, 200, 230, 260, 290, 570, 860, 1150, 1400, 1700, 2000, 2300, 2600, 2900],
            milestone_total_unlocked : vector[0, 200000000, 400000000, 600000000, 800000000, 1000000000, 1300000000, 1600000000, 1900000000, 2300000000, 2700000000, 3200000000, 3700000000, 4300000000, 4900000000, 5600000000, 6300000000, 7100000000, 8000000000, 9000000000],
        };
        0x2::table::add<u8, ProjectMilestoneConfig>(&mut v0, 1, v2);
        let v3 = ProjectMilestoneConfig{
            level                    : 2,
            locked_supply            : 9000000000,
            total_supply             : 10000000000,
            milestone_count          : 20,
            lasting_time             : 86400000,
            milestone_prices         : vector[0, 6, 12, 48, 86, 140, 170, 200, 230, 260, 290, 570, 860, 1150, 1400, 1700, 2000, 2300, 2600, 2900],
            milestone_total_unlocked : vector[0, 200000000, 400000000, 600000000, 800000000, 1000000000, 1300000000, 1600000000, 1900000000, 2300000000, 2700000000, 3200000000, 3700000000, 4300000000, 4900000000, 5600000000, 6300000000, 7100000000, 8000000000, 9000000000],
        };
        0x2::table::add<u8, ProjectMilestoneConfig>(&mut v0, 2, v3);
        let v4 = VestingConfig{
            id      : 0x2::object::new(arg0),
            version : 0,
            configs : v0,
        };
        0x2::transfer::share_object<VestingConfig>(v4);
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

    public(friend) fun new_wallet<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::ProjectManager<T0>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LockedPool<T0, T1>{
            id                      : 0x2::object::new(arg5),
            token_balance           : 0x2::coin::into_balance<T1>(arg0),
            usda_balance            : 0x2::coin::into_balance<T0>(arg1),
            milestone_round         : 0,
            incentive_type          : arg2,
            current_milestone_start : false,
            start_times             : 0,
            position_id             : arg4,
            project_id              : 0x2::object::id<0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::ProjectManager<T0>>(arg3),
            level                   : 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::get_project_manager_level<T0>(arg3),
        };
        0x2::transfer::share_object<LockedPool<T0, T1>>(v0);
        0x2::object::id<LockedPool<T0, T1>>(&v0)
    }

    public fun set_milestone_round<T0, T1>(arg0: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LockedPool<T0, T1>, arg2: u8) {
        arg1.milestone_round = arg2;
    }

    public fun set_vesting_config_count(arg0: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config::LaunchManagerAdmin, arg1: u8, arg2: u8, arg3: &mut VestingConfig) {
        0x2::table::borrow_mut<u8, ProjectMilestoneConfig>(&mut arg3.configs, arg1).milestone_count = arg2;
    }

    public fun set_vesting_config_price(arg0: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config::LaunchManagerAdmin, arg1: u8, arg2: vector<u64>, arg3: &mut VestingConfig) {
        0x2::table::borrow_mut<u8, ProjectMilestoneConfig>(&mut arg3.configs, arg1).milestone_prices = arg2;
    }

    public fun set_vesting_config_total_unlocked(arg0: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config::LaunchManagerAdmin, arg1: u8, arg2: vector<u64>, arg3: &mut VestingConfig) {
        0x2::table::borrow_mut<u8, ProjectMilestoneConfig>(&mut arg3.configs, arg1).milestone_total_unlocked = arg2;
    }

    public fun update_milestone<T0, T1>(arg0: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config::LaunchAdmin, arg1: &mut LockedPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::ProjectManager<T0>, arg4: &0x2::clock::Clock, arg5: &VestingConfig) {
        let v0 = 0x2::table::borrow<u8, ProjectMilestoneConfig>(&arg5.configs, arg1.level);
        assert_version(arg5);
        let v1 = 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::cetus::get_sui_token_price<T0, T1>(arg2);
        assert!((v1 as u64) >= get_milestone_target_price(arg1.milestone_round + 1, arg1.level, arg5), 2);
        if (arg1.current_milestone_start == false) {
            arg1.current_milestone_start = true;
            arg1.start_times = 0x2::clock::timestamp_ms(arg4);
        } else {
            assert!(0x2::clock::timestamp_ms(arg4) - arg1.start_times >= v0.lasting_time, 3);
            arg1.milestone_round = arg1.milestone_round + 1;
            arg1.current_milestone_start = false;
            let v2 = MilestoneUpdatedEvent{
                project_id            : arg1.project_id,
                count                 : 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::project_manager::get_project_count<T0>(arg3),
                milestone_round       : arg1.milestone_round,
                current_price         : v1,
                target_price          : get_milestone_target_price(arg1.milestone_round, arg1.level, arg5),
                total_unlocked_tokens : get_milestone_target_unlocked(arg1.milestone_round, arg1.level, arg5),
            };
            0x2::event::emit<MilestoneUpdatedEvent>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

