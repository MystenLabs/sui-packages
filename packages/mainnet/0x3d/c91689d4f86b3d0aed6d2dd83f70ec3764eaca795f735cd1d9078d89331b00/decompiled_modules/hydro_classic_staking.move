module 0x3dc91689d4f86b3d0aed6d2dd83f70ec3764eaca795f735cd1d9078d89331b00::hydro_classic_staking {
    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct ClassicStakingVault has store, key {
        id: 0x2::object::UID,
        total_staked: 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>,
        user_stake_info: 0x2::vec_map::VecMap<address, StakerInfo>,
    }

    struct StakerInfo has copy, drop, store {
        staked: u64,
        user_reward_per_token: u64,
        contract_reward_per_token: u64,
        staked_at: u64,
        last_claimed: u64,
        earned_reward: u64,
    }

    struct RewardDetails has store, key {
        id: 0x2::object::UID,
        reward_percentage: u64,
        reward_per_sec: u64,
    }

    struct RewardKitty has store, key {
        id: 0x2::object::UID,
        total_kitty: 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>,
        reward_per_token: u64,
    }

    struct TreasuryVault has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>,
        timestamp: u64,
        last_staked_at: u64,
    }

    struct TreasuryVaultBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct Staked has copy, drop {
        staker: address,
        staked_amount: u64,
        staked_at: u64,
    }

    struct EarnedRewards has copy, drop {
        staker: address,
        earned_rewards: u64,
    }

    struct Reinvested has copy, drop {
        staker: address,
        reinvested_amount: u64,
    }

    struct TreasuryVaultFunded has copy, drop {
        total_funds: u64,
        funds_added: u64,
    }

    struct EmergencyWithdrawl has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct RewardCollected has copy, drop {
        reward_collected: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        unstaked_amount: u64,
    }

    struct UnstakeAndExit has copy, drop {
        staker: address,
        total_reward: u64,
    }

    struct UpdatedRewardDetails has copy, drop {
        reward_percentage: u64,
        reward_per_sec: u64,
    }

    struct HYDRO_CLASSIC_STAKING has drop {
        dummy_field: bool,
    }

    public entry fun add_funds_to_treasury_vault(arg0: &Owner, arg1: 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>, arg2: u64, arg3: &mut TreasuryVault, arg4: &0x2::clock::Clock, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != 0, 6);
        assert!(0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg1) >= arg2, 7);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner_address, 2);
        assert!(arg5.version == 0, 1);
        if (arg3.timestamp == 0) {
            arg3.timestamp = time_in_secs(arg4);
            arg3.last_staked_at = time_in_secs(arg4);
        };
        0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg3.treasury, arg1);
        let v0 = TreasuryVaultFunded{
            total_funds : 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg3.treasury),
            funds_added : 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg1),
        };
        0x2::event::emit<TreasuryVaultFunded>(v0);
    }

    public entry fun change_owner(arg0: 0x2::package::UpgradeCap, arg1: Owner, arg2: address, arg3: &UpgradeVersion, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg1.owner_address;
        assert!(arg3.version == 0, 1);
        assert!(@0x0 != arg2, 3);
        assert!(0x2::tx_context::sender(arg4) == v0, 2);
        assert!(arg2 != v0, 4);
        arg1.owner_address = arg2;
        0x2::transfer::public_transfer<Owner>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg2);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg2,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun claim_rewards(arg0: &mut ClassicStakingVault, arg1: &mut TreasuryVault, arg2: &mut RewardKitty, arg3: &0x2::clock::Clock, arg4: &RewardDetails, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg5.version == 0, 1);
        assert!(0x2::vec_map::contains<address, StakerInfo>(&arg0.user_stake_info, &v0), 5);
        update_reward(0x1::option::none<u64>(), arg0, arg1, arg2, arg3, arg4, arg6);
        let v1 = 0x2::vec_map::get_mut<address, StakerInfo>(&mut arg0.user_stake_info, &v0);
        assert!(v1.earned_reward != 0, 8);
        assert!(v1.earned_reward <= 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg2.total_kitty), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg2.total_kitty, v1.earned_reward, arg6), v0);
        v1.earned_reward = 0;
        v1.last_claimed = time_in_secs(arg3);
        if (v1.staked == 0) {
            let (_, _) = 0x2::vec_map::remove<address, StakerInfo>(&mut arg0.user_stake_info, &v0);
        };
        let v4 = EarnedRewards{
            staker         : v0,
            earned_rewards : v1.earned_reward,
        };
        0x2::event::emit<EarnedRewards>(v4);
    }

    entry fun collect_reward(arg0: &Owner, arg1: &mut TreasuryVault, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 2);
        assert!(arg3.version == 0, 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(&mut arg1.id, arg2);
        let v1 = TreasuryVaultBalance<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>{dummy_field: false};
        let v2 = &mut arg1.id;
        if (0x2::dynamic_field::exists_<TreasuryVaultBalance<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(v2, v1)) {
            0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(0x2::dynamic_field::borrow_mut<TreasuryVaultBalance<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>, 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(v2, v1), v0);
        } else {
            0x2::dynamic_field::add<TreasuryVaultBalance<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>, 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(v2, v1, v0);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<TreasuryVaultBalance<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>, 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(v2, v1);
        0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg1.treasury, 0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(v3, 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(v3), arg4));
        let v4 = RewardCollected{reward_collected: 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&v0)};
        0x2::event::emit<RewardCollected>(v4);
    }

    fun init(arg0: HYDRO_CLASSIC_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        let v3 = TreasuryVault{
            id             : 0x2::object::new(arg1),
            treasury       : 0x2::coin::zero<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(arg1),
            timestamp      : 0,
            last_staked_at : 0,
        };
        let v4 = RewardKitty{
            id               : 0x2::object::new(arg1),
            total_kitty      : 0x2::coin::zero<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(arg1),
            reward_per_token : 0,
        };
        let v5 = ClassicStakingVault{
            id              : 0x2::object::new(arg1),
            total_staked    : 0x2::coin::zero<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(arg1),
            user_stake_info : 0x2::vec_map::empty<address, StakerInfo>(),
        };
        let v6 = RewardDetails{
            id                : 0x2::object::new(arg1),
            reward_percentage : 2100,
            reward_per_sec    : 1000000000,
        };
        0x2::transfer::share_object<RewardDetails>(v6);
        0x2::transfer::share_object<ClassicStakingVault>(v5);
        0x2::transfer::share_object<RewardKitty>(v4);
        0x2::transfer::share_object<TreasuryVault>(v3);
        0x2::transfer::public_transfer<Owner>(v1, v0);
        0x2::transfer::share_object<UpgradeVersion>(v2);
    }

    public entry fun reinvest_rewards(arg0: &mut ClassicStakingVault, arg1: &mut TreasuryVault, arg2: &mut RewardKitty, arg3: &0x2::clock::Clock, arg4: &RewardDetails, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg5.version == 0, 1);
        assert!(0x2::vec_map::contains<address, StakerInfo>(&arg0.user_stake_info, &v0), 5);
        let v1 = 0x1::option::some<u64>(0x2::vec_map::get<address, StakerInfo>(&arg0.user_stake_info, &v0).staked);
        update_reward(v1, arg0, arg1, arg2, arg3, arg4, arg6);
        let v2 = 0x2::vec_map::get_mut<address, StakerInfo>(&mut arg0.user_stake_info, &v0);
        let v3 = 0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg2.total_kitty, v2.earned_reward, arg6);
        let v4 = 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&v3);
        v2.earned_reward = 0;
        let v5 = &mut v3;
        stake(v5, v4, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::coin::destroy_zero<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(v3);
        let v6 = Reinvested{
            staker            : v0,
            reinvested_amount : v4,
        };
        0x2::event::emit<Reinvested>(v6);
    }

    public entry fun set_reward_details(arg0: &Owner, arg1: &mut RewardDetails, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &ClassicStakingVault, arg5: &mut TreasuryVault, arg6: &mut RewardKitty, arg7: &0x2::clock::Clock, arg8: &UpgradeVersion, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8.version == 0, 1);
        assert!(0x2::tx_context::sender(arg9) == arg0.owner_address, 2);
        update_reward_contract(arg4, arg5, arg6, arg7, arg1, arg8, arg9);
        if (!0x1::option::is_none<u64>(&arg2)) {
            arg1.reward_percentage = 0x1::option::extract<u64>(&mut arg2);
        };
        if (!0x1::option::is_none<u64>(&arg3)) {
            arg1.reward_per_sec = 0x1::option::extract<u64>(&mut arg3);
        };
        let v0 = UpdatedRewardDetails{
            reward_percentage : arg1.reward_percentage,
            reward_per_sec    : arg1.reward_per_sec,
        };
        0x2::event::emit<UpdatedRewardDetails>(v0);
    }

    public entry fun stake(arg0: &mut 0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>, arg1: u64, arg2: &mut ClassicStakingVault, arg3: &mut TreasuryVault, arg4: &mut RewardKitty, arg5: &0x2::clock::Clock, arg6: &RewardDetails, arg7: &UpgradeVersion, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg7.version == 0, 1);
        assert!(arg1 != 0, 6);
        assert!(arg1 <= 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(arg0), 7);
        assert!(arg1 >= 1000000000, 7);
        let v1 = 0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(arg0, arg1, arg8);
        let v2 = time_in_secs(arg5);
        if (0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg2.total_staked) == 0 && 0x2::vec_map::size<address, StakerInfo>(&arg2.user_stake_info) == 0) {
            0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg2.total_staked, v1);
            let v3 = StakerInfo{
                staked                    : arg1,
                user_reward_per_token     : 0,
                contract_reward_per_token : 0,
                staked_at                 : v2,
                last_claimed              : 0,
                earned_reward             : 0,
            };
            0x2::vec_map::insert<address, StakerInfo>(&mut arg2.user_stake_info, v0, v3);
            update_reward(0x1::option::some<u64>(0), arg2, arg3, arg4, arg5, arg6, arg8);
            0x2::vec_map::get_mut<address, StakerInfo>(&mut arg2.user_stake_info, &v0).earned_reward = 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg4.total_kitty);
            let v4 = Staked{
                staker        : v0,
                staked_amount : arg1,
                staked_at     : v2,
            };
            0x2::event::emit<Staked>(v4);
        } else if (0x2::vec_map::contains<address, StakerInfo>(&arg2.user_stake_info, &v0)) {
            let v5 = 0x2::vec_map::get_mut<address, StakerInfo>(&mut arg2.user_stake_info, &v0);
            v5.staked = v5.staked + arg1;
            v5.staked_at = v2;
            update_reward(0x1::option::some<u64>(v5.staked), arg2, arg3, arg4, arg5, arg6, arg8);
            0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg2.total_staked, v1);
            let v6 = Staked{
                staker        : v0,
                staked_amount : arg1,
                staked_at     : v2,
            };
            0x2::event::emit<Staked>(v6);
        } else {
            let v7 = StakerInfo{
                staked                    : arg1,
                user_reward_per_token     : 0,
                contract_reward_per_token : 0,
                staked_at                 : v2,
                last_claimed              : 0,
                earned_reward             : 0,
            };
            0x2::vec_map::insert<address, StakerInfo>(&mut arg2.user_stake_info, v0, v7);
            update_reward(0x1::option::some<u64>(0), arg2, arg3, arg4, arg5, arg6, arg8);
            0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg2.total_staked, v1);
            let v8 = Staked{
                staker        : v0,
                staked_amount : arg1,
                staked_at     : v2,
            };
            0x2::event::emit<Staked>(v8);
        };
    }

    public fun time_in_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun unstake(arg0: &mut ClassicStakingVault, arg1: 0x1::option::Option<u64>, arg2: &mut TreasuryVault, arg3: &mut RewardKitty, arg4: &0x2::clock::Clock, arg5: &UpgradeVersion, arg6: &RewardDetails, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg5.version == 0, 1);
        assert!(0x2::vec_map::contains<address, StakerInfo>(&arg0.user_stake_info, &v0), 5);
        let v1 = 0x2::coin::zero<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(arg7);
        let v2 = 0x2::vec_map::get_mut<address, StakerInfo>(&mut arg0.user_stake_info, &v0);
        if (0x1::option::is_none<u64>(&arg1)) {
            v2.staked = 0;
            v2.staked_at = time_in_secs(arg4);
            update_reward(0x1::option::some<u64>(v2.staked), arg0, arg2, arg3, arg4, arg6, arg7);
            0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut v1, 0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg0.total_staked, v2.staked, arg7));
        } else {
            let v3 = 0x1::option::extract<u64>(&mut arg1);
            assert!(v3 >= 1000000000, 7);
            assert!(v3 <= v2.staked, 7);
            v2.staked = v2.staked - v3;
            v2.staked_at = time_in_secs(arg4);
            update_reward(0x1::option::some<u64>(v2.staked), arg0, arg2, arg3, arg4, arg6, arg7);
            0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut v1, 0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg0.total_staked, v3, arg7));
        };
        let v4 = Unstaked{
            staker          : v0,
            unstaked_amount : 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&v1),
        };
        0x2::event::emit<Unstaked>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(v1, v0);
    }

    public entry fun unstake_and_exit(arg0: &mut ClassicStakingVault, arg1: &mut TreasuryVault, arg2: &mut RewardKitty, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &RewardDetails, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        unstake(arg0, 0x1::option::none<u64>(), arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x2::vec_map::get<address, StakerInfo>(&arg0.user_stake_info, &v0).earned_reward;
        claim_rewards(arg0, arg1, arg2, arg3, arg5, arg4, arg6);
        let v2 = UnstakeAndExit{
            staker       : v0,
            total_reward : v1,
        };
        0x2::event::emit<UnstakeAndExit>(v2);
    }

    fun update_reward(arg0: 0x1::option::Option<u64>, arg1: &mut ClassicStakingVault, arg2: &mut TreasuryVault, arg3: &mut RewardKitty, arg4: &0x2::clock::Clock, arg5: &RewardDetails, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_map::contains<address, StakerInfo>(&arg1.user_stake_info, &v0), 5);
        let v1 = 0x2::vec_map::get_mut<address, StakerInfo>(&mut arg1.user_stake_info, &v0);
        let v2 = update_reward_kitty(arg2, arg3, arg4, arg5, arg6);
        let v3 = 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg1.total_staked);
        let v4 = if (v3 == 0) {
            0
        } else {
            (((v2 as u256) * (1000000000 as u256) / (v3 as u256)) as u64)
        };
        arg3.reward_per_token = arg3.reward_per_token + v4;
        let v5 = if (0x1::option::is_none<u64>(&arg0)) {
            ((((arg3.reward_per_token - v1.contract_reward_per_token) as u256) * (v1.staked as u256) / (1000000000 as u256)) as u64)
        } else {
            ((((arg3.reward_per_token - v1.contract_reward_per_token) as u256) * (0x1::option::extract<u64>(&mut arg0) as u256) / (1000000000 as u256)) as u64)
        };
        v1.user_reward_per_token = v4;
        v1.earned_reward = v1.earned_reward + v5;
        v1.contract_reward_per_token = arg3.reward_per_token;
    }

    public fun update_reward_contract(arg0: &ClassicStakingVault, arg1: &mut TreasuryVault, arg2: &mut RewardKitty, arg3: &0x2::clock::Clock, arg4: &RewardDetails, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.version == 0, 1);
        let v0 = update_reward_kitty(arg1, arg2, arg3, arg4, arg6);
        let v1 = 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg0.total_staked);
        let v2 = if (v1 == 0) {
            0
        } else {
            (((v0 as u256) * (1000000000 as u256) / (v1 as u256)) as u64)
        };
        arg2.reward_per_token = arg2.reward_per_token + v2;
    }

    fun update_reward_kitty(arg0: &mut TreasuryVault, arg1: &mut RewardKitty, arg2: &0x2::clock::Clock, arg3: &RewardDetails, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = time_in_secs(arg2);
        let v1 = (((((arg3.reward_percentage as u256) * ((arg3.reward_per_sec * (v0 - arg0.last_staked_at)) as u256)) as u256) / 10000) as u64);
        assert!(0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg0.treasury) >= v1, 9);
        0x2::coin::join<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg1.total_kitty, 0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg0.treasury, v1, arg4));
        arg0.last_staked_at = v0;
        v1
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 2);
        assert!(arg1.version < 0, 1);
        arg1.version = 0;
    }

    public entry fun withdraw_reward_kitty(arg0: &Owner, arg1: &mut RewardKitty, arg2: address, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 2);
        let v0 = 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg1.total_kitty);
        assert!(v0 != 0, 6);
        assert!(arg2 != @0x0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg1.total_kitty, v0, arg4), arg2);
        let v1 = EmergencyWithdrawl{
            amount    : v0,
            recipient : arg2,
        };
        0x2::event::emit<EmergencyWithdrawl>(v1);
    }

    public entry fun withdraw_treasury_vault(arg0: &Owner, arg1: &mut TreasuryVault, arg2: address, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 2);
        let v0 = 0x2::coin::value<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&arg1.treasury);
        assert!(v0 != 0, 6);
        assert!(arg2 != @0x0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>>(0x2::coin::split<0x1bf196b392e30926b658ffd9e7eae20a29afafab536f1b7ae8e0caef079a170d::hydro_token::HYDRO_TOKEN>(&mut arg1.treasury, v0, arg4), arg2);
        let v1 = EmergencyWithdrawl{
            amount    : v0,
            recipient : arg2,
        };
        0x2::event::emit<EmergencyWithdrawl>(v1);
    }

    // decompiled from Move bytecode v6
}

